# coding: utf-8
require 'libis-tools'
require 'libis/services/service_error'
require 'libis/services/rest_client'

module Libis
  module Services
    module Alma

      class SruService
        include ::Libis::Services::RestClient

        def initialize(url = 'https://eu.alma.exlibrisgroup.com/view/sru')
          configure(url)
        end

        def search(field, value, library = '32KUL_LIBIS_NETWORK')

          result = get library, version: '1.2', operation: 'searchRetrieve', recordSchema: 'marcxml',
                       query: "#{field}=#{value}"

          if result.is_a?(Libis::Tools::XmlDocument)

            unless result['//diag:diagnostic'].blank?
              raise Libis::Services::ServiceError, "#{result['/searchRetrieveResponse/diag:diagnostic/diag:message']}"
            end

            return result.document.xpath('//marc:record', 'marc' => 'http://www.loc.gov/MARC21/slim').map do |record|
              Libis::Tools::XmlDocument.parse(record.to_s)
            end
          end

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
