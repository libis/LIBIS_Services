# encoding: utf-8

require 'libis/tools/extend/hash'
require_relative 'client'

module LIBIS
  module Services
    module RosettaService

      class ProducerHandler < LIBIS::Services::RosettaService::Client

        def initialize(base_url = 'http://depot.lias.be')
          super 'deposit', 'ProducerWebServices', base_url
        end

        def get_user_id(name)
          request :get_internal_user_id_by_external_id, arg0: name
        end

      end

    end
  end
end