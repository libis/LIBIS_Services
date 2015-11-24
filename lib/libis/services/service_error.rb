# encoding: utf-8

module Libis
  module Services

    class ServiceError < Exception
      attr_accessor :message

      def initialize(error)
        @message = error.to_s
      end

    end

  end
end