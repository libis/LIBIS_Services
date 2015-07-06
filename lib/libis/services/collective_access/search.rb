# coding: utf-8

require 'libis/services/generic_search'

require_relative 'connector'

module Libis
  module Services
    module CollectiveAccess

      class Search < Connector
        include ::Libis::Services::GenericSearch

        def initialize(host = nil)
          super 'Search', host
        end

        def query(query, options = {})
          request :querySoap, type: (options[:index] || 'ca_objects'), query: query
        end

      end

    end
  end
end
