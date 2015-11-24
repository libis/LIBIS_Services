require 'virtus'

module Libis
  module Services
    module Rosetta
      class OaiSet
        # noinspection RubyResolve
        include Virtus.model nullify_blank: true

        attribute :description, String
        attribute :name, String
        attribute :spec, String

        def to_hash
          super.cleanup
        end

      end
    end
  end
end