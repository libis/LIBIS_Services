require 'virtus'
require 'libis/tools/extend/hash'

module Libis
  module Services
    module Rosetta
      class DepositActivity
        # noinspection RubyResolve
        include Virtus.model nullify_blank: true

        STATUS = %w'Inprocess Incomplete Rejected Draft Approved Declined'

        attribute :deposit_activity_id, Integer
        attribute :creation_date, String
        attribute :status, String
        attribute :title, String
        attribute :producer_agent_id, Integer
        attribute :submit_date, String
        attribute :update_date, String
        attribute :sip_id, Integer
        attribute :producer_id, Integer
        attribute :sip_reason, String

        def to_hash
          super.cleanup
        end

      end

      class DepositActivityList
        # noinspection RubyResolve
        include Virtus.model nullify_blank: true

        attribute :total_records, String
        attribute :records, Array(DepositActivity)

        def to_hash
          {
              total_records: total_records,
              records: records.map {|record| record.to_hash}
          }
        end

      end

    end
  end
end