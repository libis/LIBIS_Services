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

        def call_raw(operation, args = {})
          data = request operation.to_s.to_sym, args

          # remove wrapper
          data = data["#{operation}_response".to_sym]
          data.delete(:'@xmlns:ns1')

          # drill down the returned Hash
          data = data.first.last while data.is_a?(Hash) && 1 == data.size

          data
        end

        def call(operation, args = {})
          # upstream call
          data = call_raw(operation, args)

          # try to parse as XML
          if data.is_a?(String)
            xml_data = Libis::Tools::XmlDocument.parse(data).to_hash(
                empty_tag_value: nil,
                delete_namespace_attributes: true,
                strip_namespaces: true,
                convert_tags_to: lambda { |tag| tag.to_sym }
            )
            data = xml_data unless xml_data.empty?
          end

          return data unless data.is_a?(Hash)

          # drill down
          data = data.first.last if 1 == data.size

          return data unless data.is_a?(Hash)

          # check for errors
          if data.delete :is_error
            error data.delete :error_description
            return nil
          end

          # only delete if there is other info. ProducerService isUserExists uses this field as return value.
          data.delete :error_description if data.size > 1

          # continue drilling down the Hash
          data = data.first.last while data.is_a?(Hash) && 1 == data.size

          # return
          data
        end

        def request_object(method, klass, args = {})
          data = call method, args
          return nil unless data.is_a?(Hash)
          klass.new(data)
        end

        def request_array(method, args = {})
          data = call method, args
          data = data.split(/[\s,]+/) if data.is_a?(String)
          data = [data] if data.is_a?(Hash)
          data.is_a?(Array) ? data : []
        end

        def reqeust_object_array(method, klass, args = {})
          data = request_array(method, args)
          data.map { |x| klass.new(x) }
        end

      end

    end
  end
end
