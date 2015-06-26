# encoding: utf-8

module Libis
  module Services

    class SoapError < Exception
      attr_accessor :code, :text, :detail, :name

      def initialize(error)
        @code = error[:fault][:faultcode] rescue nil
        @text = error[:fault][:faultstring] rescue nil
        @detail = error[:fault][:detail] rescue nil
        @name = @detail.first.first rescue nil
      end

      def message
        "#{code}:#{name} #{text}"
      end
    end

  end
end