# coding: utf-8

require_relative 'aleph/search'
require_relative 'primo/search'
require_relative 'sharepoint/search'
require_relative 'scope/search'

module Libis
  module Services

    class SearchFactory
      def initialize(format, *args)
        @search_class = self.class.const_get("Libis::Services::#{format}::Search")
        @search_client = @search_class.new *args

      rescue Exception => e
        puts e.message
        exit -1
      end

      def query(query, options = {})
        @search_client.get(query, options)
      end

      def find(term, options = {})
        @search_client.find(term, options)
      end

      def each(options = {}, &block)
        @search_client.each(options, &block)
      end

      def next_record(options = {}, &block)
        @search_client.next_record(options, &block)
      end

    end

  end
end