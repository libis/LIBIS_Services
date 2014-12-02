# encoding: utf-8

require 'libis/tools/extend/hash'
require_relative 'client'

module LIBIS
  module Services
    module RosettaService

      class SipHandler < LIBIS::Services::RosettaService::Client

        def initialize(base_url = 'http://depot.lias.be')
          super 'repository', 'SipWebServices', base_url
        end

        def get_info(sip_id)
          request :get_sip_status_info, arg0: sip_id
        end

        def get_ies(sip_id)
          result = request :get_sip_i_es, arg0: sip_id
          result.split(',')
        end

        protected

      end

    end
  end
end