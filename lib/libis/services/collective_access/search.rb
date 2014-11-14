# coding: utf-8

require_relative 'connector'

module LIBIS
  module Services
    module CollectiveAccessService

      class Search < Connector

        def initialize(host = nil)
          super 'Search', host
        end

        def query(query, type = nil)
          type ||= 'ca_objects'
          request :querySoap, type: type, query: query
        end

      end

    end
  end
end
