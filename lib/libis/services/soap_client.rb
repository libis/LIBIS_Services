# coding: utf-8

require 'savon'

require 'libis/tools/xml_document'

module Libis
  module Services

    module SoapClient
      attr_reader :client

      def configure(wsdl, options = {})
        opts = {
            wsdl: wsdl,
            raise_errors: false,
            soap_version: 1,
            filters: [:password],
            pretty_print_xml: true,
        }.merge options

        @client = Savon.client(opts) { yield if block_given? }
      end

      def operations
        @client.operations
      end

      def request(method, message = {}, call_options = {}, parse_options = {})
        begin
          response = client.call(method, message: message) do |locals|
            call_options.each do |key, value|
              locals.send(key, value)
            end
          end

          return yield(response) if block_given?
          parse_result(response, parse_options)

        rescue Exception => ex
          return {error: ex}
        end

      end

      protected

      def parse_result(response, options = {})
        unless response.success?
          error = []
          error << "SOAP Error: #{response.soap_fault.to_s}" if response.soap_fault?
          error << "HTTP Error: #{response.http_error.to_s}" if response.http_error?
          raise RuntimeError error.join('\n')
        end
        result = result_parser(response.body, options)
        raise RuntimeError, result[:error] if (result.is_a?(Hash) && result[:error])
        result
      end

      def result_parser(response, options = {})
        response
      end

    end

  end
end
