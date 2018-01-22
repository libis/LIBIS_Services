# encoding: utf-8

require_relative 'deposit_activity'
require_relative 'client'

module Libis
  module Services
    module Rosetta

      class DepositHandler < ::Libis::Services::Rosetta::Client

        def initialize(base_url = 'http://depot.lias.be', options = {})
          super 'deposit', 'DepositWebServices', {url: base_url}.merge(options)
        end

        # @param [Object] flow_id ID of the material flow used
        # @param [Object] subdir name of the load directory
        # @param [Object] producer_id ID of the Producer
        # @param [Object] deposit_set_id ID of the set of deposits
        def submit(flow_id, subdir, producer_id, deposit_set_id = '1')
          call :submit_deposit_activity,
                     arg0: @pds_handle,
                     arg1: flow_id,
                     arg2: subdir,
                     arg3: producer_id,
                     arg4: deposit_set_id
        end

        def deposits(opts = {})
          options = opts.dup
          flow_id = options.delete :flow_id
          submit_date_from, submit_date_to = options.delete :submit_date
          submit_date_to ||= submit_date_from if submit_date_from
          update_date_from, update_date_to = options.delete :update_date
          update_date_to ||= update_date_from if update_date_from
          if submit_date_from
            if flow_id
              get_by_submit_flow submit_date_from, submit_date_to, flow_id, options
            else
              get_by_submit_date submit_date_from, submit_date_to, options
            end
          elsif update_date_from
            if flow_id
              get_by_update_flow update_date_from, update_date_to, flow_id, options
            else
              get_by_update_date update_date_from, update_date_to, options
            end
          else
            error "unsupported deposit query: #{opts}."
            []
          end
        end

        # @param [String] date_from Start date for lookup range
        # @param [String] date_to End date for lookup range
        # @param [Hash] options optional string parameters limiting the search with:
        # - status: Status of the deposit [All (default), In process, Rejected, Draft, Approved, Declined]
        # - producer_id: optional, limits by producer_id
        # - agent_id: optional, limits by agent_id
        # - start_record: optional, pagination start
        # - end_record: optional, pagination end
        def get_by_submit_date(date_from, date_to, options = {})
          options = {
              status: 'All',
              producer_id: nil,
              agent_id: nil,
              start_record: nil,
              end_record: nil
          }.merge options
          params = {
              arg0: @pds_handle,
              arg1: options[:status],
              arg2: options[:producer_id],
              arg3: options[:agent_id],
              arg4: date_from,
              arg5: date_to,
              arg6: options[:start_record],
              arg7: options[:end_record]
          }.cleanup
          request_activities :get_deposit_activity_by_submit_date, params
        end

        # @param [String] date_from Start date for lookup range
        # @param [String] date_to End date for lookup range
        # @param [Object] flow_id ID of the material flow used
        # @param [Hash] options optional string parameters limiting the search with:
        # - status: Status of the deposit [All (default), In process, Rejected, Draft, Approved, Declined]
        # - producer_id: optional, limits by producer_id
        # - agent_id: optional, limits by agent_id
        # - start_record: optional, pagination start
        # - end_record: optional, pagination end
        def get_by_submit_flow(date_from, date_to, flow_id, options = {})
          options = {
              status: 'All',
              producer_id: nil,
              agent_id: nil,
              start_record: nil,
              end_record: nil
          }.merge options
          params = {
              arg0: @pds_handle,
              arg1: options[:status],
              arg2: flow_id,
              arg3: options[:producer_id],
              arg4: options[:agent_id],
              arg5: date_from,
              arg6: date_to,
              arg7: options[:start_record],
              arg8: options[:end_record]
          }.cleanup
          request_activities :get_deposit_activity_by_submit_date_by_material_flow, params
        end

        # @param [String] date_from Start date for lookup range
        # @param [String] date_to End date for lookup range
        # @param [Hash] options optional string parameters limiting the search with:
        # - status: Status of the deposit [All (default), In process, Rejected, Draft, Approved, Declined]
        # - producer_id: optional, limits by producer_id
        # - agent_id: optional, limits by agent_id
        # - start_record: optional, pagination start
        # - end_record: optional, pagination end
        def get_by_update_date(date_from, date_to, options = {})
          options = {
              status: 'All',
              producer_id: nil,
              agent_id: nil,
              start_record: nil,
              end_record: nil
          }.merge options
          params = {
              arg0: @pds_handle,
              arg1: options[:status],
              arg2: options[:producer_id],
              arg3: options[:agent_id],
              arg4: date_from,
              arg5: date_to,
              arg6: options[:start_record],
              arg7: options[:end_record]
          }.cleanup
          request_activities :get_deposit_activity_by_update_date, params
        end

        # @param [String] date_from Start date for lookup range
        # @param [String] date_to End date for lookup range
        # @param [Object] flow_id ID of the material flow used
        # @param [Hash] options optional string parameters limiting the search with:
        # - status: Status of the deposit [All (default), In process, Rejected, Draft, Approved, Declined]
        # - producer_id: optional, limits by producer_id
        # - agent_id: optional, limits by agent_id
        # - start_record: optional, pagination start
        # - end_record: optional, pagination end
        def get_by_update_flow(date_from, date_to, flow_id, options = {})
          options = {
              status: 'All',
              producer_id: nil,
              agent_id: nil,
              start_record: nil,
              end_record: nil
          }.merge options
          params = {
              arg0: @pds_handle,
              arg1: options[:status],
              arg2: flow_id,
              arg3: options[:producer_id],
              arg4: options[:agent_id],
              arg5: date_from,
              arg6: date_to,
              arg7: options[:start_record],
              arg8: options[:end_record]
          }.cleanup
          request_activities :get_deposit_activity_by_update_date_by_material_flow, params
        end

        protected

        def request_activities(method, args = {})
          data = call method, args
          list = Rosetta::DepositActivityList.new(total_records: data[:total_records])
          records = data[:records][:record] rescue nil
          list.records = (records.is_a?(Array) ? records : [records]).map { |record| Rosetta::DepositActivity.new(record)}
          list
        end
      end

    end
  end
end