# coding: utf-8
require 'libis-tools'

require 'libis/services/rest_client'

module Libis
  module Services
    module Alma

      class WebService
        include ::Libis::Services::RestClient

        def initialize(url = 'https://api-eu.hosted.exlibrisgroup.com/almaws/v1/bibs')
          configure(url)
        end

        def get_marc(alma_id, apikey)
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
