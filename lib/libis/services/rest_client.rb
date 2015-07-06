# coding: utf-8

require 'rest-client'
require 'nori'
require 'json'
require 'gyoku'

module Libis
  module Services

    module RestClient
      attr_reader :client

      def configure(url, options = {})
        @client = ::RestClient::Resource.new(url, options)
      end

      def get(path, params = {}, headers = {}, &block)
        response = client[path].get({params: params}.merge headers, &block)
        parse_result response, &block
      rescue ::RestClient::Exception => e
        return {error_type: e.class.name, error_name: e.message, response: parse_result(e.response, &block)}
      end

      def post_url(path, params = {}, headers = {}, &block)
        response = client[path].post({params: params}.merge headers, &block)
        parse_result response, &block
      rescue ::RestClient::Exception => e
        return {error_type: e.class.name, error_name: e.message, response: parse_result(e.response, &block)}
      end

      def post_data(path, payload, headers = {}, &block)
        response = client[path].post(payload, headers, &block)
        parse_result response, &block
      rescue ::RestClient::Exception => e
        return {error_type: e.class.name, error_name: e.message, response: parse_result(e.response, &block)}
      end

      def put_url(path, params = {}, headers = {}, &block)
        response = client[path].put({params: params}.merge headers, &block)
        parse_result response, &block
      rescue ::RestClient::Exception => e
        return {error_type: e.class.name, error_name: e.message, response: parse_result(e.response, &block)}
      end

      def put_data(path, payload, headers = {}, &block)
        response = client[path].put(payload, headers, &block)
        parse_result response, &block
      rescue ::RestClient::Exception => e
        return {error_type: e.class.name, error_name: e.message, response: parse_result(e.response, &block)}
      end

      protected

      def parse_result(response)
        block_given? ? yield(response) : result_parser(response)
      end

      def result_parser(response)
        response
      end

    end

  end
end
