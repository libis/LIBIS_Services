# coding: utf-8

require 'libis/services/soap_client'
require 'libis/tools/extend/hash'

require 'awesome_print'

module LIBIS
  module Services
    module RosettaService

      class Client
        include LIBIS::Services::SoapClient

        def initialize(section, service, base_url = 'http://depot.lias.be')
          configure "#{base_url}/dpsws/#{section}/#{service}?wsdl", strip_namespaces: true
        end

        def pds_handle=(handle)
          @pds_handle = handle
        end

        def get_heart_bit
          request :get_heart_bit
        end

        protected

        # @param [Hash] response
        # @return [LIBIS::Tools::XmlDocument]
        def result_parser(response)
          result = response.values.first.values.first rescue nil
          return {error: result['message_desc']} if (result.is_a?(Hash) && result['is_error'])
          result
        end

      end

    end
  end
end
