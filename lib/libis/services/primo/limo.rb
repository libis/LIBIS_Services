# coding: utf-8
require 'libis-tools'

require 'libis/services/rest_client'

module Libis
  module Services
    module Primo

      class Limo
        include ::Libis::Services::RestClient

        def initialize(url = 'http://limo.libis.be')
          configure(url)
        end

        def get_marc(alma_id)
          result = get "primo_library/libweb/jqp/record/#{alma_id}.xml"
          return result if result.is_a?(Libis::Tools::XmlDocument)

          raise Libis::Services::ServiceError, "#{result[:error_type]} - #{result[:error_name]}" if result[:error_type]
          raise Libis::Services::ServiceError, "Unexpected reply: '#{result.to_s}' (#{result.class})"
        end

        def get_pnx(alma_id)
          result = get "primo_library/libweb/jqp/record/#{alma_id}.pnx"
          return result if result.is_a?(Libis::Tools::XmlDocument)

          raise Libis::Services::ServiceError, "#{result[:error_type]} - #{result[:error_name]}" if result[:error_type]
          raise Libis::Services::ServiceError, "Unexpected reply: '#{result.to_s}' (#{result.class})"
        end

        protected

        def result_parser(response)
          Libis::Tools::XmlDocument.parse(response) rescue response
        end
      end
    end
  end
end
