# coding: utf-8

require 'libis/services/extend/http_fetch'

module Libis
  module Services

    module GenericSearch

      #noinspection RubyResolve
      attr_accessor :host
      #noinspection RubyResolve
      attr_reader :query, :term, :index, :base
      #noinspection RubyResolve
      attr_reader :num_records, :set_number
      #noinspection RubyResolve
      attr_reader :record_pointer, :session_id

      def query(query, options = {})
        raise RuntimeError, 'to be implemented'
      end

      def find(term, options = {})
        query(term, options)
      end

      def each(options = {}, &block)
        raise RuntimeError, 'to be implemented'
      end

      def next_record(options = {}, &block)
        raise RuntimeError, 'to be implemented'
      end

    end

  end
end
