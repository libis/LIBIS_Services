# encoding: utf-8

require 'libis/tools/xml_document'
require_relative 'client'

module Libis
  module Services
    module Rosetta

      class IeHandler < Libis::Services::Rosetta::Client

        def initialize(base_url = 'http://depot.lias.be', options = {})
          super 'repository', 'IEWebServices', {url: base_url}.merge(options)
        end

        def get_mets(ie, flags = 0)
          result = request(:get_ie, pds_handle: @pds_handle, ie_pid: ie, flags: flags)
          Libis::Tools::MetsFile.parse(result)
        end

        def get_metadata(ie)
          request(:get_md, pds_handle: @pds_handle, 'PID' => ie)
        end

        protected

        def result_parser(response, options = {})
          result = super(response)
          if result.is_a? String
            xml_result = Libis::Tools::XmlDocument.parse(result) rescue nil
            result = xml_result unless xml_result.nil?
          end
          result
        end

      end
    end
  end
end