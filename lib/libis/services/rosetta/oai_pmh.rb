require 'libis/services/oai'

module Libis
  module Services
    module Rosetta
      class OaiPmh < Libis::Services::Oai

        def initialize(base_url = 'http://depot.lias.be', options = {})
          super('http://depot.lias.be')
        end

        def collections(institute, token = nil, query = Query.new)
          query.set = "#{institute}-collections"
          records(token, query)
        end

      end
    end
  end
end
