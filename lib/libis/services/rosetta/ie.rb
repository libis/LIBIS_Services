require 'virtus'

module Libis
  module Services
    module Rosetta
      class Ie
        # noinspection RubyResolve
        include Virtus.model nullify_blank: true

        attribute :pid, String

        def to_hash
          super.cleanup
        end

      end
    end
  end
end