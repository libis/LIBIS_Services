require 'libis/services/oai'
require 'libis/tools/xml_document'

module Libis
  module Services
    module Rosetta
      class OaiPmh < Libis::Services::Oai

        def initialize(base_url = 'https://repository.teneo.libis.be', options = {})
          super(base_url + '/oaiprovider/request')
        end

        def collections(institute, token_or_query = nil)
          records(token_or_query_to_hash(token_or_query).merge(set: "#{institute}-collections"))
        end

      end
    end
  end
end
