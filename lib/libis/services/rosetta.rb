module Libis
  module Services
    module Rosetta
      autoload :Service, 'libis/services/rosetta/service'

      autoload :PdsHandler, 'libis/services/rosetta/pds_handler'
      autoload :ProducerHandler, 'libis/services/rosetta/producer_handler'
      autoload :DepositHandler, 'libis/services/rosetta/deposit_handler'
      autoload :SipHandler, 'libis/services/rosetta/sip_handler'
      autoload :IeHandler, 'libis/services/rosetta/ie_handler'
      autoload :CollectionHandler, 'libis/services/rosetta/collection_handler'
      autoload :OaiPmh, 'libis/services/rosetta/oai_pmh'
    end
  end
end
