require_relative 'services/version'

module Libis
  module Services

    autoload :HttpError, 'libis/services/http_error'
    autoload :SoapError, 'libis/services/soap_error'
    autoload :ServiceError, 'libis/services/service_error'

    autoload :SoapClient, 'libis/services/soap_client'
    autoload :RestClient, 'libis/services/rest_client'

    autoload :OracleClient, 'libis/services/oracle_client'
    autoload :DigitoolConnector, 'libis/services/digitool_connector'
    autoload :DigitalEntityManager, 'libis/services/digital_entity_manager'
    autoload :MetaDataManager, 'libis/services/meta_data_manager'

    autoload :SharepointConnector, 'libis/services/sharepoint_connector'

    autoload :Primo, 'libis/services/primo'

  end
end

require_relative 'services/rosetta'