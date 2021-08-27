require_relative 'pds_handler'
require_relative 'producer_handler'
require_relative 'deposit_handler'
require_relative 'sip_handler'
require_relative 'ie_handler'
require_relative 'collection_handler'
require_relative 'oai_pmh'

require 'libis/tools/mets_file'

require 'csv'
require 'write_xlsx'
require 'libis/tools/extend/hash'
require 'libis/tools/extend/string'
require 'awesome_print'

require_relative '../service_error'

module Libis
  module Services
    module Rosetta

      # noinspection RubyTooManyInstanceVariablesInspection
      class Service

        attr_reader :pds_service, :producer_service, :deposit_service, :sip_service, :ie_service, :collection_service

        # @param [String] base_url
        def initialize(base_url = 'https://repository.teneo.libis.be', pds_url = 'https://pds.libis.be', opts = {})
          @pds_service = Libis::Services::Rosetta::PdsHandler.new pds_url
          @producer_service = Libis::Services::Rosetta::ProducerHandler.new base_url, opts
          @deposit_service = Libis::Services::Rosetta::DepositHandler.new base_url, opts
          @sip_service = Libis::Services::Rosetta::SipHandler.new base_url, opts
          @ie_service = Libis::Services::Rosetta::IeHandler.new base_url, opts
          @collection_service = Libis::Services::Rosetta::CollectionHandler.new base_url, opts
          @oai_pmh_service = Libis::Services::Rosetta::OaiPmh.new base_url, opts
        end

        # @param [String] name
        # @param [String] passwd
        # @param [String] institute
        # @return [String] PDS handle
        def login(name, passwd, institute)
          handle = nil
          0.upto(3).each do |i|
            handle = @pds_service.login(name, passwd, institute)
            break if handle
            sleep(3 ** i)
          end
          raise ServiceError, 'Could not login into Rosetta.' unless handle
          @producer_service.pds_handle = handle
          @deposit_service.pds_handle = handle
          @sip_service.pds_handle = handle
          @ie_service.pds_handle = handle
          @collection_service.pds_handle = handle
          handle
        end

        # Searches for all deposits in the date range and for the given flow id. The method returns a list of all
        # deposits, including information about the sip, the related IEs and a breakdown of the IE's METS file.
        #
        # @param [String] from_date
        # @param [String] to_date
        # @param [String] flow_id
        # @param [String] options
        # @return [Hash] detailed deposit information
        def get_deposits(from_date, to_date, flow_id, options = {})
          deposits = @deposit_service.get_by_submit_flow(from_date, to_date, flow_id, {status: 'Approved'}.merge(options))
          deposits.each do |deposit|
            ies = @sip_service.get_ies(deposit[:sip])
            ies_info = ies.map do |ie|
              title = nil
              id = nil
              begin
                md = @ie_service.get_metadata(ie).to_hash['mets:mets']
                dc = md['mets:dmdSec']['mets:mdWrap']['mets:xmlData']['dc:record']
                title = dc['dc:title']
                id = dc['dc:identifier']
              rescue
                # ignore
              end
              # retrieve ie mets file
              ie_info = @ie_service.get_mets(ie)
              {
                  ie: ie,
                  title: title,
                  id: id,
                  content: ie_info
              }.cleanup
            end
            deposit[:ies] = ies_info
          end
          deposits.sort! { |x, y| x[:ies][0][:id] <=> y[:ies][0][:id] }
          # deposits.each { |dep| dep[:ies].each { |ie| puts "DEP ##{dep[:deposit]} - SIP ##{dep[:sip]} - IE ##{ie[:ie]} - #{ie[:id]} - #{ie[:title]}" } }
          deposits
        end

        # @param [String] report_file
        # @param [Array] deposits
        def get_deposit_report(report_file, deposits)
          # create and open Workbook
          workbook = WriteXLSX.new(report_file)

          # set up some formatting
          ie_data_header_format = workbook.add_format(bold: 1)
          rep_name_format = workbook.add_format(bold: 1)
          file_header_format = workbook.add_format(bold: 1)

          # First Sheet is an overview of all dossiers
          overview = workbook.add_worksheet('IE overview')
          ie_data_keys = Set.new %w[id dossier link disposition]
          ie_list = [] # ie info will be collected in this array to be printed later

          # iterate over all deposits
          deposits.each do |deposit|
            # iterate over all IEs
            deposit[:ies].sort { |x, y| x[:id] <=> y[:id] }.each do |ie|
              @ie = ie
              id = (ie[:id] || ie[:ie])
              # noinspection RubyStringKeysInHashInspection
              ie_data = {
                  'id' => "#{id}",
                  'dossier' => ie[:title],
                  'disposition' => (ie[:content][:dmd]['date'] rescue nil),
                  'link' => "http://depot.lias.be/delivery/DeliveryManagerServlet?dps_pid=#{ie[:ie]}",
              }.cleanup
              [
                  # (ie[:content][:dmd] rescue nil),
                  (ie[:content][:amd][:tech]['generalIECharacteristics'] rescue nil),
                  (ie[:content][:amd][:rights]['accessRightsPolicy'] rescue nil)
              ].each do |data|
                ie_data.merge! data if data
              end
              dossier_sheet = workbook.add_worksheet(id.gsub(/[\\\/*?]+/, '.'))
              dossier_row = 0

              ie[:content].each do |rep_name, rep|
                next unless rep_name.is_a?(String)
                @rep = rep
                file_data_keys = Set.new %w(folder naam link mimetype puid formaat versie)
                file_list = []

                dossier_sheet.write_row(dossier_row, 0, [rep_name], rep_name_format)
                %w(preservationType usageType).each do |key|
                  dossier_row += 1
                  dossier_sheet.write_row(
                      dossier_row, 0,
                      [
                          key.underscore.gsub('_', ' '),
                          rep[:amd][:tech]['generalRepCharacteristics'][key]
                      ]
                  )
                end
                dossier_row += 2

                file_proc = lambda do |file|
                  @file = file
                  if file[:id]
                    tech = file[:amd][:tech]
                    # noinspection RubyStringKeysInHashInspection
                    file_data = {
                        'folder' => (tech['generalFileCharacteristics']['fileOriginalPath'] rescue '').split('/')[1..-1].join('\\'),
                        'naam' => (tech['generalFileCharacteristics']['fileOriginalName'] rescue nil),
                        'link' => ("http://depot.lias.be/delivery/DeliveryManagerServlet?dps_pid=#{file[:id]}" rescue nil),
                        'mimetype' => (tech['fileFormat']['mimeType'] rescue nil),
                        'puid' => (tech['fileFormat']['formatRegistryId'] rescue nil),
                        'formaat' => (tech['fileFormat']['formatDescription'] rescue nil),
                        'versie' => (tech['fileFormat']['formatVersion'] rescue nil),
                        'viruscheck' => (tech['fileVirusCheck']['status'] rescue nil),
                        'file_type' => (tech['generalFileCharacteristics']['FileEntityType']),
                        'groep' => file[:group],
                    }
                    data = tech['fileValidation']
                    if data
                      valid = (data['isValid'] == 'true') rescue nil
                      well_formed = (data['isWellFormed'] == 'true') rescue nil
                      file_data['validatie'] = if valid && well_formed
                                                 'OK'
                                               else
                                                 'niet OK'
                                               end
                    end
                    data = tech['significantProperties']
                    if data
                      file_data[data['significantPropertiesType']] = data['significantPropertiesValue']
                    end
                    data = file[:dmd]
                    if data
                      data.each { |key, value| file_data[key] = value }
                    end
                    file_list << file_data
                    file_data_keys.merge file_data.keys
                  else
                    file.each do |_, value|
                      next unless value.is_a? Hash
                      # noinspection RubyScope
                      file_proc.call(value)
                    end
                  end
                end

                rep.keys.each do |key|
                  file_proc.call(rep[key]) if key.is_a?(String)
                end

                table_start = dossier_row
                dossier_sheet.write_row(dossier_row, 0, file_data_keys.to_a, file_header_format)
                file_list.each do |file_info|
                  dossier_row += 1
                  file_data = []
                  file_data_keys.each { |key| file_data << file_info[key] }
                  dossier_sheet.write_row(dossier_row, 0, file_data)
                end
                table_end = dossier_row

                dossier_sheet.add_table(
                    table_start, 0, table_end, file_data_keys.size - 1,
                    style: 'Table Style Medium 16', name: rep[:id],
                    columns: file_data_keys.map { |key| {header: key} }
                )

                dossier_row += 2
              end
              ie_data_keys.merge ie_data.keys
              ie_list << ie_data
            end
          end

          # write ie data to overview worksheet
          overview.write_row(0, 0, ie_data_keys.to_a, ie_data_header_format)
          overview_row = 1
          ie_list.each do |ie_info|
            ie_data = []
            ie_data_keys.each { |key| ie_data << ie_info[key] }
            overview.write_row(overview_row, 0, ie_data)
            overview_row += 1
          end

        rescue Exception => e
          puts e.message
          puts e.backtrace
            # close and save workbook
        ensure
          workbook.close
        end

        # @param [String] report_file
        # @param [Array] deposits
        def get_dav_deposit_report(report_file, deposits)
          # create and open Workbook
          workbook = WriteXLSX.new(report_file)

          # set up some formatting
          ie_data_header_format = workbook.add_format(bold: 1)
          rep_name_format = workbook.add_format(bold: 1)
          file_header_format = workbook.add_format(bold: 1)

          # First Sheet is an overview of all dossiers
          overview = workbook.add_worksheet('dossier overzicht')
          ie_data_keys = Set.new %w[id dossier link disposition]
          ie_list = [] # ie info will be collected in this array to be printed later

          # iterate over all deposits
          deposits.each do |deposit|
            # iterate over all IEs
            deposit[:ies].sort { |x, y| x[:id] <=> y[:id] }.each do |ie|
              @ie = ie
              id = (ie[:id] || ie[:ie])
              # noinspection RubyStringKeysInHashInspection
              ie_data = {
                  'id' => "#{id}",
                  'dossier' => ie[:title],
                  'disposition' => (ie[:content][:dmd]['date'] rescue nil),
                  'link' => "http://depot.lias.be/delivery/DeliveryManagerServlet?dps_pid=#{ie[:ie]}",
              }.cleanup
              [
                  # (ie[:content][:dmd] rescue nil),
                  (ie[:content][:amd][:tech]['generalIECharacteristics'] rescue nil),
                  (ie[:content][:amd][:rights]['accessRightsPolicy'] rescue nil)
              ].each do |data|
                ie_data.merge! data if data
              end
              dossier_sheet = workbook.add_worksheet(id.gsub(/[\\\/*?]+/, '.'))
              dossier_row = 0

              ie[:content].each do |rep_name, rep|
                next unless rep_name.is_a?(String)
                @rep = rep
                file_data_keys = Set.new %w(folder naam link mimetype puid formaat versie)
                file_list = []

                dossier_sheet.write_row(dossier_row, 0, [rep_name], rep_name_format)
                %w(preservationType usageType).each do |key|
                  dossier_row += 1
                  dossier_sheet.write_row(
                      dossier_row, 0,
                      [
                          key.underscore.gsub('_', ' '),
                          rep[:amd][:tech]['generalRepCharacteristics'][key]
                      ]
                  )
                end
                dossier_row += 2

                file_proc = lambda do |file|
                  @file = file
                  if file[:id]
                    tech = file[:amd][:tech]
                    # noinspection RubyStringKeysInHashInspection
                    file_data = {
                        'folder' => (tech['generalFileCharacteristics']['fileOriginalPath'] rescue '').split('/')[1..-1].join('\\'),
                        'naam' => (tech['generalFileCharacteristics']['fileOriginalName'] rescue nil),
                        'link' => ("http://depot.lias.be/delivery/DeliveryManagerServlet?dps_pid=#{file[:id]}" rescue nil),
                        'mimetype' => (tech['fileFormat']['mimeType'] rescue nil),
                        'puid' => (tech['fileFormat']['formatRegistryId'] rescue nil),
                        'formaat' => (tech['fileFormat']['formatDescription'] rescue nil),
                        'versie' => (tech['fileFormat']['formatVersion'] rescue nil),
                        'viruscheck' => (tech['fileVirusCheck']['status'] rescue nil),
                        'file_type' => (tech['generalFileCharacteristics']['FileEntityType']),
                        'groep' => file[:group],
                    }
                    data = tech['fileValidation']
                    if data
                      valid = (data['isValid'] == 'true') rescue nil
                      well_formed = (data['isWellFormed'] == 'true') rescue nil
                      file_data['validatie'] = if valid && well_formed
                                                 'OK'
                                               else
                                                 'niet OK'
                                               end
                    end
                    data = tech['significantProperties']
                    if data
                      file_data[data['significantPropertiesType']] = data['significantPropertiesValue']
                    end
                    data = file[:dmd]
                    if data
                      data.each { |key, value| file_data[key] = value }
                    end
                    file_list << file_data
                    file_data_keys.merge file_data.keys
                  else
                    file.each do |_, value|
                      next unless value.is_a? Hash
                      # noinspection RubyScope
                      file_proc.call(value)
                    end
                  end
                end

                rep.keys.each do |key|
                  file_proc.call(rep[key]) if key.is_a?(String)
                end

                table_start = dossier_row
                dossier_sheet.write_row(dossier_row, 0, file_data_keys.to_a, file_header_format)
                file_list.each do |file_info|
                  dossier_row += 1
                  file_data = []
                  file_data_keys.each { |key| file_data << file_info[key] }
                  dossier_sheet.write_row(dossier_row, 0, file_data)
                end
                table_end = dossier_row

                dossier_sheet.add_table(
                    table_start, 0, table_end, file_data_keys.size - 1,
                    style: 'Table Style Medium 16', name: rep[:id],
                    columns: file_data_keys.map { |key| {header: key} }
                )

                dossier_row += 2
              end
              ie_data_keys.merge ie_data.keys
              ie_list << ie_data
            end
          end

          # write ie data to overview worksheet
          overview.write_row(0, 0, ie_data_keys.to_a, ie_data_header_format)
          overview_row = 1
          ie_list.each do |ie_info|
            ie_data = []
            ie_data_keys.each { |key| ie_data << ie_info[key] }
            overview.write_row(overview_row, 0, ie_data)
            overview_row += 1
          end

        rescue Exception => e
          puts e.message
          puts e.backtrace
            # close and save workbook
        ensure
          workbook.close
        end

        def file
          @file
        end

        def ie
          @ie
        end

        def rep
          @rep
        end

      end

    end
  end
end
