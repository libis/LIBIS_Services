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
          result = call_raw :get_ie, pds_handle: @pds_handle, ie_pid: ie, flags: flags
          Libis::Tools::MetsFile.parse(result)
        end

        def get_metadata(ie)
          result = call_raw :get_md, pds_handle: @pds_handle, 'PID' => ie
          Libis::Tools::MetsFile.parse(result)
        end

      end
    end
  end
end