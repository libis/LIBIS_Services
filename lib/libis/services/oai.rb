require 'oai'
require 'libis/tools/extend/hash'
require 'libis/tools/xml_document'
require 'libis/services/service_error'

module Libis
  module Services
    class Oai
      include OAI::XPath

      class Query

        def initialize(options = {})
          @options = options
          @options[:metadata_prefix] ||= 'oai_dc'
        end

        def [](key, value)
          @options[key] = value
        end

        def to_hash
          { 
            from: @options[:from],
            until: @options[:until],
            metadata_prefix: @options[:metadata_prefix],
            set: @options[:set],
            resumption_token: @options[:token] || @options[:resumption_token]
          }.cleanup
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

      def metadata_formats(identifier = nil)
        do_oai_request(:list_metadata_formats, {identifier: identifier})
      end

      def identifiers(token_or_query = nil)
        do_oai_request(:list_identifiers, token_or_query_to_hash(token_or_query))
      end

      def records(token_or_query = nil)
        do_oai_request(:list_records, token_or_query_to_hash(token_or_query))
      end

      def record(identifier, metadata_prefix = 'oai_dc')
        do_oai_request(:get_record, identifier: identifier, metadata_prefix: metadata_prefix)
      end

      protected

      def token_or_query_to_hash(token_or_query)
        case token_or_query
        when Hash
          Query.new(token_or_query).to_hash
        when Query
          token_or_query.to_hash
        when String
          { resumption_token: token_or_query }
        else
          {}
        end
      end

      private
      
      def do_oai_request(method, options = {})
        response = options.cleanup.empty? ? @oai_client.send(method): @oai_client.send(method, options.cleanup)
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
            Libis::Tools::XmlDocument.parse(obj.to_s).to_hash
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
