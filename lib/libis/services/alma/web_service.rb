# coding: utf-8
require 'libis-tools'
require 'libis/services/service_error'
require 'libis/services/rest_client'

module Libis
  module Services
    module Alma

      class WebService
        include ::Libis::Services::RestClient

        def initialize(url = 'https://api-eu.hosted.exlibrisgroup.com/almaws/v1/bibs')
          configure(url)
        end

        def get_marc(alma_id, apikey = nil)
          apikey ||= case alma_id
                      when /1480$/
                        'l7xx8879c82a7d7b453a887a6e6dca8300fd'
                      else
                        raise Libis::Services::ServiceError, "No Alma API key available for '#{alma_id}'"
                    end
          get alma_id, apikey: apikey
        end

        protected

        def result_parser(response)
          Libis::Tools::XmlDocument.parse(response)
        end

      end
    end
  end
end
