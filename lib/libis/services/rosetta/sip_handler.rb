# encoding: utf-8

require 'libis/tools/extend/hash'
require_relative 'client'

module Libis
  module Services
    module Rosetta

      class SipHandler < Libis::Services::Rosetta::Client

        def initialize(base_url = 'http://depot.lias.be', options = {})
          super 'repository', 'SipWebServices', {url: base_url}.merge(options)
        end

        def get_info(sip_id)
          request :get_sip_status_info, arg0: sip_id
        end

        def get_ies(sip_id)
          result = request :get_sip_i_es, arg0: sip_id
          result.split(',')
        end

        protected

        def result_parser(response, options = {})
          puts response
          response
        end

      end

    end
  end
end