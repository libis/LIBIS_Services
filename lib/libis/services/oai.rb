require 'oai'
require 'libis/tools/extend/hash'
require 'libis/services/service_error'

module Libis
  module Services
    class Oai
      include OAI::XPath

      class Query
        attr_accessor :from, :until, :set, :metadata_prefix

        def intialize(metadata_prefix = 'oai_dc')
          @from = @until = @set = nil
          @metadata_prefix = metadata_prefix
        end

        def to_hash
          { from: @from, until: @until, metadata_prefix: @metadata_prefix, set: @set }.cleanup
        end

      end

      def initialize(url, options = {})
        options[:debug] = true
        @oai_client = OAI::Client.new(url, options)
      end

      def identify
        do_oai_request(:identify)
      end

      def sets(token = nil)
        options = { resumption_token: token }
        do_oai_request(:list_sets, options)
      end

      def metdata_formats(identifier = nil)
        do_oai_request(:list_metadata_formats, {identifier: identifier})
      end

      def identifiers(token = nil, query = Query.new)
        options = token ? {resumption_token: token} : query.to_hash
        do_oai_request(:list_identifiers, options)
      end

      def records(token = nil, query = Query.new)
        options = token ? {resumption_token: token} : query.to_hash
        do_oai_request(:list_records, options)
      end

      def record(identifier, metadata_prefix)
        do_oai_request(:get_record, identifier: identifier, metadata_prefix: metadata_prefix)
      end

      private

      def do_oai_request(method, options = {})
        response = @oai_client.send(method, options.cleanup)
        object_to_hash(response)
      rescue OAI::Exception => e
        raise Libis::Services::ServiceError, "OAI Error: #{e.code} - #{e.message}"
      end

      def object_to_hash(obj)
        case obj
          when Array
            obj.map { |x| object_to_hash(x) }
          when Hash
            obj.each_with_object({}) do |k,v,h|
              h[k] = object_to_hash(v)
            end
          when REXML::Element
            obj.to_s
          when OAI::Response, OAI::Header, OAI::Record, OAI::MetadataFormat, OAI::Set
            result = obj.instance_variables.map do |x|
              x[1..-1].to_sym
            end.select do |x|
              ![:_source, :doc, :resumption_block].include? x
            end.each_with_object({}) do |x, h|
              h[x] = object_to_hash obj.send(x)
            end
            if obj.methods.include?(:entries)
              result[:entries] = obj.entries.map do |entry|
                object_to_hash(entry)
              end
            end
            result
          else
            obj
        end
      end

    end
  end
end
