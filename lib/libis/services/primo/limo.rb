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
          get 'primo_library/libweb/jqprimo/helpers/record_helper.jsp', id: "#{alma_id}.xml"
        end

        def get_pnx(alma_id)
          get 'primo_library/libweb/jqprimo/helpers/record_helper.jsp', id: "#{alma_id}.pnx"
        end

        protected

        def result_parser(response)
          Libis::Tools::XmlDocument.parse(response)
        end
      end
    end
  end
end
