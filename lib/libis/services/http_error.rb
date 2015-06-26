# encoding: utf-8

module Libis
  module Services

    class HttpError < Exception
      attr_accessor :code, :header, :body

      def initialize(error)
        @code = error[:code]
        @header = error[:header]
        @body = error[:body]
      end

      def message
        code.to_s
      end
    end

  end
end