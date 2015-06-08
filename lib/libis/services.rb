module Libis
  module Services

    autoload :SoapClient, 'libis/services/soap_client'
    autoload :RestClient, 'libis/services/rest_client'

    autoload :OracleClient, 'libis/services/oracle_client'
    autoload :DigitoolConnector, 'libis/services/digitool_connector'
    autoload :DigitalEntityManager, 'libis/services/digital_entity_manager'
    autoload :MetaDataManager, 'libis/services/meta_data_manager'

    autoload :SharepointConnector, 'libis/services/sharepoint_connector'

    autoload :Rosetta, 'libis/services/rosetta'

  end
end