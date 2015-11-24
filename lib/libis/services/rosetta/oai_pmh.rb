# encoding: utf-8
require 'oai'
require 'libis/tools/extend/hash'

module Libis
  module Services
    module Rosetta
      class OaiPmh
        include OAI::XPath

        def initialize(base_url = 'http://depot.lias.be', options = {})
          @oai_client = OAI::Client.new(base_url + '/oaiprovider/request', options)
        end

        def sets
          response = @oai_client.list_sets
          response.map do |oai_set|
            {name: oai_set.name, spec: oai_set.spec, description: oai_set.description}.cleanup
          end
        end

        def collections(institute, status = {})
          result = records("#{institute}-collections", status)
          result.map do |record|
            record[:title] = xpath_first(record[:metadata], './/dc:title').text
          end
        end

        def records(spec, status = {})
          options = { set: spec }
          options[:resumption_token] = status[:token] if status[:token]
          result = []
          response = @oai_client.list_records(options)
          response.each do |record|
            next if record.deleted?
            result << {
                id: record.header.identifier,
                date: record.header.datestamp,
                metadata: record.metadata,
            }
          end
          result
        end

      end
    end
  end
end
