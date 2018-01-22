require 'libis/services/oai'

module Libis
  module Services
    module Rosetta
      class OaiPmh < Libis::Services::Oai

        def initialize(base_url = 'http://depot.lias.be', options = {})
          super(base_url + '/oaiprovider/request')
        end

        def collections(institute, token = nil, query = Query.new)
          query.set = "#{institute}-collections"
          records(token, query)
        end

      end
    end
  end
end
