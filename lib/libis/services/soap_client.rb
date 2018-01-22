# coding: utf-8

require 'savon'

require 'libis/tools/xml_document'
require_relative 'http_error'
require_relative 'soap_error'

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
            read_timeout: 30,
            open_timeout: 5,
        }.merge options

        @client = Savon.client(opts) { yield if block_given? }
      end

      def operations
        @client.operations
      end

      def request(method, message = {}, call_options = {}, parse_options = {})
        response = client.call(method, message: message) do |locals|
          call_options.each do |key, value|
            locals.send(key, value)
          end
        end

        return yield(response) if block_given?
        parse_result(response, parse_options)

      rescue IOError, EOFError, Errno::ECONNRESET, Errno::ECONNABORTED, Errno::EPIPE => e
        debug "Exception: #{e.class.name} '#{e.message}'"
        unless (tries ||= 0) > 2; sleep(5 ** tries); tries += 1; retry; end
        raise Libis::Services::ServiceError, "Persistent network error: #{e.class.name} '#{e.message}'"
      rescue Net::ReadTimeout, Timeout::Error => e
        debug "Exception: #{e.class.name} '#{e.message}'"
        unless (tries ||= 0) > 1; sleep(5 ** tries); tries += 1; retry; end
        raise Libis::Services::ServiceError, "Network timeout error: #{e.class.name} '#{e.message}'"
      end

      protected

      def parse_result(response, options = {})
        raise SoapError.new response.soap_fault.to_hash if response.soap_fault?
        raise HttpError.new response.http_error.to_hash if response.http_error?
        self.result_parser(response.body, options)
      end

      def result_parser(response, options = {})
        response
      end

    end

  end
end
