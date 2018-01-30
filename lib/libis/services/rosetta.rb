module Libis
  module Services
    module Rosetta
      autoload :Service, 'rosetta/service'

      autoload :PdsHandler, 'rosetta/pds_handler'
      autoload :ProducerHandler, 'rosetta/producer_handler'
      autoload :DepositHandler, 'rosetta/deposit_handler'
      autoload :SipHandler, 'rosetta/sip_handler'
      autoload :IeHandler, 'rosetta/ie_handler'
      autoload :CollectionHandler, 'rosetta/collection_handler'
      autoload :OaiPmh, 'rosetta/oai_pmh'
    end
  end
end
