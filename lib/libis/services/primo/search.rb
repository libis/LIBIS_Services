# coding: utf-8
require 'json'

require 'libis/services/rest_client'
require 'libis/services/generic_search'

module Libis
  module Services
    module Primo

      class Search
        include ::Libis::Services::RestClient
        include ::Libis::Services::GenericSearch

        def initialize(url = 'https://services.libis.be')
          configure(url)
        end

        def query(query, options = {})
          index = options.delete(:index) || 'any'
          get 'search', {query: "#{index}:#{query}"}.merge(options)
        end

        def find(term, options = {})
          max_count = options.delete(:max_count) || 100
          result = []
          while result.size < max_count
            reply = query(term, options.merge(from: result.size + 1))
            max_count = [max_count, reply[:count]].min
            reply[:data].each do |record|
              next unless result.size < max_count
              result << record[:display]
            end
          end
          result
        end

        protected

        def result_parser(response)
          JSON.parse(response, symbolize_names: true)
        end
      end
    end
  end
end
