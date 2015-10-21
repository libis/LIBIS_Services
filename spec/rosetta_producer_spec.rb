# encoding: utf-8
require_relative 'spec_helper'
require 'yaml'

require 'libis/tools/config_file'

require 'libis/services/rosetta/pds_handler'
require 'libis/services/rosetta/producer_handler'

describe 'Rosetta Producer Service' do

  let(:credentials) { Libis::Tools::ConfigFile.new File.join(File.dirname(__FILE__), 'credentials-test.yml') }
  # noinspection RubyResolve
  let(:admin) { credentials.admin }
  # noinspection RubyResolve
  let(:admin_usr) { admin.user }
  # noinspection RubyResolve
  let(:admin_uid) { admin.user_id }
  # noinspection RubyResolve
  let(:admin_pwd) {admin.password}
  # noinspection RubyResolve
  let(:admin_ins) {admin.institute}

  let(:pds_handler) do
    # noinspection RubyResolve
    Libis::Services::Rosetta::PdsHandler.new(credentials.pds_url)
  end

  let(:handle) { pds_handler.login(admin_usr, admin_pwd, admin_ins) }

  let(:contact_info) { {user_id: credentials.contact.user_id, name: 'Test User'} }
  # noinspection RubyResolve
  subject(:producer_handler) do
    handler = Libis::Services::Rosetta::ProducerHandler.new credentials.rosetta_url,
                                                            log: credentials.debug,
                                                            log_level: credentials.debug_level
    handler.pds_handle = handle
    handler
  end

  before :each do
    producer_handler.pds_handle = handle
  end

  context 'user info' do
    let(:user_id) { admin_uid }

    let(:user_name) { admin_usr }

    it 'gets user id' do
      result = producer_handler.user_id(user_name)
      expect(result).to eq user_id
    end

    it 'checks user id' do
      result = producer_handler.is_user?(user_name)
      expect(result).to be_truthy

      result = producer_handler.is_user?(user_id)
      expect(result).to be_truthy

      result = producer_handler.is_user?('user_that_does_not_exist')
      # Disabled: Rosetta API bug
      # expect(result).to be_falsey
      expect(result).to be_truthy
    end

  end

  context 'producer' do

    let(:producer_id) { credentials.producer.id }
    let(:producer_data) { credentials.producer.data.to_hash }
    let(:producer_info) { ::Libis::Services::Rosetta::Producer.new(producer_data).to_hash }
    let(:updated_info) { {email: 'nomail@mail.com', telephone_2: '0032 16 32 22 22'} }
    let(:new_producer_info) {
      producer_data.merge(
          authoritative_name: 'new test producer',
          email: 'nomail@mail.com',
          telephone_2: '0032 16 32 22 22',
      )
    }

    def new_producer_id(id = nil)
      $new_producer_id = id if id
      "#{$new_producer_id}"
    end

    it 'get producer' do
      result = producer_handler.producer(producer_id)
      expect(result).not_to be_nil
      expect(result.to_hash).to match producer_data
      expect(producer_data).to match result.to_hash
    end

    it 'create producer' do
      result = producer_handler.new_producer(new_producer_info)
      expect(result).not_to be_nil
      expect(result).to match /^\d+$/
      new_producer_id(result)
    end

    it 'update producer' do
      result = producer_handler.producer(new_producer_id, updated_info)
      expect(result).not_to be_nil
      expect(result).to eq new_producer_id

      result = producer_handler.producer(new_producer_id)
      expect(result).not_to be_nil
      expect(result.to_hash).to match new_producer_info.merge(updated_info)
    end

    it 'delete producer' do
      result = producer_handler.delete_producer new_producer_id
      expect(result).not_to be_nil
      expect(result).to eq new_producer_id
    end

    # noinspection RubyResolve
    it 'get material flows of producer' do
      result = producer_handler.material_flows credentials.producer.id
      expect(result).not_to be_nil
      expect(result).to include credentials.material_flow.automated.to_h
      # Disabled: Rosetta bug ?
      # expect(result).to include credentials.material_flow.manual.to_h
    end

  end

  # Disabled section. Rosett bugs and insuficient dcumentating cause these tests to fail.
  #
  # context 'producer agent' do
  #
  #   let(:new_agent) {
  #     Libis::Services::Rosetta::User.new(
  #         record_type: 'PUBLIC',
  #         user_name: 'testagent',
  #         first_name: 'Test',
  #         last_name: 'Agent',
  #         email_address: 'test@mail.com',
  #         street: 'Willem de Croylaan 54',
  #         city: 'Heverlee',
  #         zip: '3001',
  #         telephone_1: '0032 16 32 22 66',
  #     # password: 'abc123ABC',
  #     # password_verify: 'abc123ABC',
  #     ).to_hash
  #   }
  #
  #   # noinspection RubyResolve
  #   let(:agent_data) { credentials.producer_agent.data.to_hash }
  #   let(:agent) { ::Libis::Services::Rosetta::User.new(agent_data) }
  #   # noinspection RubyResolve
  #   let(:agent_id) { credentials.producer_agent.user_id }
  #   # noinspection RubyResolve
  #   let(:agent_ins) { credentials.producer_agent.institute}
  #
  #   def new_agent_id(val = nil)
  #     $new_agent_id = val.to_i if val
  #     "#{$new_agent_id}"
  #   end
  #
  #   it 'get info' do
  #     result = producer_handler.agent(agent_id)
  #     expect(result).not_to be_nil
  #     expect(result).to include new_agent
  #   end
  #
  #   it 'create' do
  #     result = producer_handler.new_agent new_agent
  #     expect(result).not_to be_nil
  #     expect(result).to match /^\d+$/
  #     new_agent_id result
  #   end
  #
  #   it 'get info' do
  #     result = producer_handler.agent(new_agent_id)
  #     expect(result).not_to be_nil
  #     expect(result).to include new_agent
  #   end
  #
  #   it 'update info' do
  #     # update data
  #     updated_agent = new_agent.dup
  #     updated_agent[:email] = 'other@mail.com'
  #     result = producer_handler.agent(new_agent_id, updated_agent)
  #     expect(result).not_to be_nil
  #     expect(result).to eq new_agent_id
  #
  #     # retrieve updated data
  #     result = producer_handler.agent(new_agent_id)
  #     expect(result).not_to be_nil
  #     expect(result.to_hash).to match updated_agent
  #   end
  #
  #
  #   it 'delete' do
  #     result = producer_handler.delete_agent new_agent_id
  #     expect(result).not_to be_nil
  #     expect(result).to eq new_agent_id
  #   end
  #
  #   it 'get producers' do
  #     result = producer_handler.agent_producers agent_id, agent_ins
  #     expect(result).not_to be_nil
  #     expect(result).to eq [credentials.producer.user_id]
  #   end
  #
  # end

  context 'contact' do

    let(:contact_id) { credentials.contact.user_id }
    let(:contact_info) { credentials.contact.data.to_hash }
    let(:new_contact) {
      ::Libis::Services::Rosetta::User.new(
          first_name: 'New',
          last_name: 'Contact',
          language: 'English',
          status: 'ACTIVE',
          telephone_1: '0032 16 32 00 00',
          email_address: 'nomail@mail.com',
          street: 'Oude Markt 1',
          city: 'Leuven',
          country: 'Belgium',
          zip: '3000',
      )
    }
    let(:updated_info) { {email_address: 'new_contact@mail.com', telephone_2: '0032 16 32 22 22'} }
    let(:updated_contact) { new_contact.to_hash.dup.merge(updated_info) }

    def new_contact_id(val = nil)
      $new_contact_id = val.to_i if val
      "#{$new_contact_id}"
    end

    it 'get info' do
      result = producer_handler.contact(contact_id)
      expect(result).not_to be_nil
      expect(result.to_hash).to match contact_info
    end

    it 'create' do
      result = producer_handler.new_contact new_contact
      expect(result).not_to be_nil
      expect(result).to match /^\d+$/
      new_contact_id result
    end

    it 'update info' do
      # update data
      result = producer_handler.contact(new_contact_id, updated_info)
      expect(result).not_to be_nil
      expect(result).to eq new_contact_id

      # retrieve updated data
      result = producer_handler.contact(new_contact_id)
      expect(result).not_to be_nil
      expect(result.to_hash).to match updated_contact
    end

    it 'delete' do
      result = producer_handler.delete_contact new_contact_id
      expect(result).not_to be_nil
      expect(result).to eq new_contact_id
    end

  end

end