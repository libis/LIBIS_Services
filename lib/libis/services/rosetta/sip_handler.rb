# encoding: utf-8

require 'libis/tools/extend/hash'
require_relative 'client'
require_relative 'sip'
require_relative 'ie'

module Libis
  module Services
    module Rosetta

      class SipHandler < Libis::Services::Rosetta::Client

        def initialize(base_url = 'https://repository.teneo.libis.be', options = {})
          super 'repository', 'SipWebServices', {url: base_url}.merge(options)
        end

        def get_info(sip_id)
          request_object :get_sip_status_info, Rosetta::Sip, arg0: sip_id
        end

        def get_ies(sip_id)
          request_array(:get_sip_i_es, arg0: sip_id).map {|ie| Rosetta::Ie.new(pid: ie)}

        end

      end

    end
  end
end