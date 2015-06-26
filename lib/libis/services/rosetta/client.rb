# coding: utf-8

require 'libis/services/soap_client'
require 'libis/tools/extend/hash'
require 'libis/tools/config'
require 'libis/tools/logger'

require 'awesome_print'

module Libis
  module Services
    module Rosetta

      class Client
        include ::Libis::Services::SoapClient
        include ::Libis::Tools::Logger

        def initialize(section, service, options = {})
          opts = {strip_namespaces: true, logger: ::Libis::Tools::Config.logger}.merge options
          base_url = opts.delete(:url) || 'http://depot.lias.be'
          configure "#{base_url}/dpsws/#{section}/#{service}?wsdl", opts
        end

        def pds_handle=(handle)
          @pds_handle = handle
        end

        def get_heart_bit
          request :get_heart_bit
        end

        protected

        def do_request(operation, args = {})
          reply = request operation.to_s.to_sym, args
          key = "#{operation.to_s}_response".to_sym
          return reply unless reply.has_key? key
          reply[key].delete :'@xmlns:ns1'
          reply[key]
        end

        def parse_data(data, data_tag = nil)
          puts data
          err = data.delete :is_error
          if err
            error data.delete :error_message
            return nil
          end
          data = data[data_tag] if data_tag
          data
        end

        def parse_xml_data(data, data_tag = nil, sub_tag = nil)
          xml_data = Libis::Tools::XmlDocument.parse(data).
              to_hash(strip_namespaces: true, convert_tags_to: lambda { |tag| tag.snakecase.to_sym} )
          xml_data = xml_data[data_tag] if data_tag
          parse_data(xml_data, sub_tag)
        end


        # @param [Hash] response
        # @return [Libis::Tools::XmlDocument]
        # def result_parser(response, options = {})
        #   result = response.values.first.values.first rescue nil
        #   return {error: result['message_desc']} if (result.is_a?(Hash) && result['is_error'])
        #   result
        # end

      end

    end
  end
end
