require 'virtus'

module Libis
  module Services
    module Rosetta
      class Sip
        # noinspection RubyResolve
        include Virtus.model nullify_blank: true

        MODULE = %w'PER'
        STAGE = %w'Finished'
        STATUS = %w'FINISHED'

        attribute :id, Integer
        attribute :module, String
        attribute :stage, String
        attribute :status, String

        def to_hash
          super.cleanup
        end

      end
    end
  end
end