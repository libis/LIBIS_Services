# encoding: utf-8

require 'libis/tools/extend/hash'
require_relative 'client'

module Libis
  module Services
    module Rosetta

      class ProducerHandler < Libis::Services::Rosetta::Client

        def initialize(base_url = 'http://depot.lias.be', options = {})
          super 'deposit', 'ProducerWebServices', {url: base_url}.merge(options)
        end

        def user_id(external_id)
          reply = do_request :get_internal_user_id_by_external_id, arg0: external_id
          reply[:get_internal_user_id_by_external_id]
        end

        def is_user?(user_id)
          do_request :is_user_exists, arg0: @pds_handle, arg1: user_id
        end

        def producer(producer_id, producer_info = nil)
          if producer_info
            do_request :update_producer, arg0: @pds_handle, arg1: producer_id, arg2: producer_info
          else
            do_request :get_producer_details, arg0: @pds_handle, arg1: producer_id
          end
        end

        def producer=(producer_info)
          do_request :create_producer, arg0: @pds_handle, arg1: producer_info
        end

        def producer!(producer_id)
          do_request :remove_producer, arg0: @pds_handle, arg1: producer_id
        end

        def agent(agent_id, agent_info = nil)
          if agent_info
            do_request :update_producer_agent, arg0: @pds_handle, arg1: agent_id, arg2: agent_info
          else
            do_request :get_producer_agent, arg0: @pds_handle, arg1: agent_id
          end
        end

        def agent=(agent_info)
          do_request :create_producer_agent, arg0: @pds_handle, arg1: agent_info
        end

        def agent!(agent_id)
          do_request :remove_producer_agent, arg0: @pds_handle, arg1: agent_id
        end

        def link_agent(agent_id, producer_id)
          do_request :link_producer_agent_to_producer, arg0: @pds_handle, arg1: producer_id, arg2: agent_id
        end

        def unlink_agent(agent_id, producer_id)
          do_request :unlink_producer_agent_from_producer, arg0: @pds_handle, arg1: producer_id, arg2: agent_id
        end

        def agent_producers(agent_id, institution = nil)
          if institution
            reply = do_request :get_producers_of_producer_agent_with_ins, arg0: agent_id, arg1: institution
            get_array_from_reply(reply, :producers_result_with_ins)
          else
            reply = do_request :get_producers_of_producer_agent, arg0: agent_id
            get_array_from_reply(reply, :producers_result)
          end
        end

        def contact(user_id, user_info = nil)
          if user_info
            do_request :update_contact, arg0: @pds_handle, arg1: user_id, arg2: user_info
          else
            do_request :get_contact, arg0: @pds_handle, arg1: user_id
          end
        end

        def contact=(user_info)
            do_request :create_contact, arg0: @pds_handle, arg1: user_info
        end

        def contact!(user_id)
            do_request :remove_contact, arg0: @pds_handle, arg1: user_id
        end

        def link_contact(contact_id, producer_id, primary = true)
          do_request :link_contact_to_producer, arg0: @pds_handle, arg1: producer_id, arg2: contact_id, arg3: (!!primary).to_s.upcase
        end

        def unlink_contact(contact_id, producer_id)
          do_request :unlink_contact_from_producer, arg0: @pds_handle, arg1: producer_id, arg2: contact_id
        end

        def material_flows(producer_id)
          reply = do_request :get_material_flows_of_producer, arg0: producer_id
          get_array_from_reply(reply, :material_flows_result)
        end

        protected

        def get_array_from_reply(reply, tag)
          data = parse_xml_data(reply[tag], :deposit_data, :dep_data)
          return [] if data.nil?
          data.is_a?(Array) ? data : [data]
        end

      end

    end
  end
end