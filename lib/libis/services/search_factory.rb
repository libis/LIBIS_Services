# coding: utf-8

require_relative 'aleph/search'
require_relative 'primo/search'
require_relative 'sharepoint/search'
require_relative 'scope/search'

module Libis
  module Services
    class SearchFactory
      def initialize(format)
        @search_class = self.class.const_get("Libis::Services::#{format}::Search")
      rescue Exception => e
        puts e.message
        exit -1
      end

      def new_search(*args)
        @search_class.new *args
      end
    end
  end
end