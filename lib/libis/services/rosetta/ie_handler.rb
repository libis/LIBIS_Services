# encoding: utf-8

require 'libis/tools/xml_document'
require_relative 'client'

module LIBIS
  module Services
    module RosettaService

      class IeHandler < LIBIS::Services::RosettaService::Client

        def initialize(base_url = 'http://depot.lias.be')
          super 'repository', 'IEWebServices', base_url
        end

        def get_mets(ie, flags = 0)
          result = request(:get_ie, pds_handle: @pds_handle, ie_pid: ie, flags: flags)
          LIBIS::Tools::MetsFile.parse(result)
        end

        def get_metadata(ie)
          request(:get_md, pds_handle: @pds_handle, 'PID' => ie)
        end

        def result_parser(response)
          result = super(response)
          if result.is_a? String
            xml_result = LIBIS::Tools::XmlDocument.parse(result) rescue nil
            result = xml_result unless xml_result.nil?
          end
          result
        end

      end
    end
  end
end