# encoding: utf-8
require 'libis/tools/extend/hash'
require 'libis/tools/xml_document'
require_relative 'producer'
require_relative 'user'

require_relative 'client'
module Libis
  module Services
    module Rosetta

      class ProducerHandler < Libis::Services::Rosetta::Client


        def initialize(base_url = 'http://depot.lias.be', options = {})
          super 'backoffice', 'ProducerWebServices', {url: base_url}.merge(options)
        end

        def user_id(external_id)
          call :get_internal_user_id_by_external_id, arg0: external_id
        end

        def is_user?(user_id)
          data = call :is_user_exists, arg0: @pds_handle, arg1: user_id
          data == "User name #{user_id} already exists"
        end

        def producer(producer_id, producer_info = nil)
          if producer_info
            info = producer(producer_id)
            return nil if info.nil?
            (producer_info.is_a?(Rosetta::Producer) ? producer_info.attributes : producer_info).each do |name, value|
              info[name] = value
            end
            call :update_producer, arg0: @pds_handle, arg1: producer_id, arg2: info.to_xml
          else
            request_object :get_producer_details, Rosetta::Producer, arg0: @pds_handle, arg1: producer_id
          end
        end

        def new_producer(producer_info)
          producer_info = Rosetta::Producer.new(producer_info) unless producer_info.is_a?(Rosetta::Producer)
          call :create_producer, arg0: @pds_handle, arg1: producer_info.to_xml
        end

        def delete_producer(producer_id)
          call :remove_producer, arg0: @pds_handle, arg1: producer_id
        end

        def agent(agent_id, agent_info = nil)
          if agent_info
            info = agent(agent_id)
            return nil if info.nil?
            (agent_info.is_a?(Rosetta::User) ? agent_info.attributes : agent_info).each do |name, value|
              info[name] = value
            end
            call :update_producer_agent, arg0: @pds_handle, arg1: agent_id, arg2: info.to_xml
          else
            request_object :get_producer_agent, Rosetta::User, arg0: @pds_handle, arg1: agent_id
          end
        end

        def new_agent(agent_info)
          agent_info = Rosetta::User.new(agent_info) unless agent_info.is_a?(Rosetta::User)
          call :create_producer_agent, arg0: @pds_handle, arg1: agent_info.to_xml
        end

        def delete_agent(agent_id)
          call :remove_producer_agent, arg0: @pds_handle, arg1: agent_id
        end

        def link_agent(agent_id, producer_id)
          call :link_producer_agent_to_producer, arg0: @pds_handle, arg1: producer_id, arg2: agent_id
        end

        def unlink_agent(agent_id, producer_id)
          call :unlink_producer_agent_from_producer, arg0: @pds_handle, arg1: producer_id, arg2: agent_id
        end

        def agent_producers(agent_id, institution = nil)
          if institution
            request_array :get_producers_of_producer_agent_with_ins, arg0: agent_id, arg1: institution
          else
            request_array :get_producers_of_producer_agent, arg0: agent_id
          end
        end

        def contact(contact_id, contact_info = nil)
          if contact_info
            info = contact(contact_id)
            return nil if info.nil?
            (contact_info.is_a?(Rosetta::User) ? contact_info.attributes : contact_info).each do |name, value|
              info[name] = value
            end
            call :update_contact, arg0: @pds_handle, arg1: contact_id, arg2: info.to_xml
          else
            request_object :get_contact, Rosetta::User, arg0: @pds_handle, arg1: contact_id
          end
        end

        def new_contact(contact_info)
          contact_info = Rosetta::User.new(contact_info) unless contact_info.is_a?(Rosetta::User)
          call :create_contact, arg0: @pds_handle, arg1: contact_info.to_xml
        end

        def delete_contact(contact_id)
          call :remove_contact, arg0: @pds_handle, arg1: contact_id
        end

        def link_contact(contact_id, producer_id, primary = true)
          call :link_contact_to_producer, arg0: @pds_handle, arg1: producer_id, arg2: contact_id, arg3: (!!primary).to_s.upcase
        end

        def unlink_contact(contact_id, producer_id)
          call :unlink_contact_from_producer, arg0: @pds_handle, arg1: producer_id, arg2: contact_id
        end

        def material_flows(producer_id)
          request_array :get_material_flows_of_producer, arg0: producer_id
        end

      end

    end
  end
end