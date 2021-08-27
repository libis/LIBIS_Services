# encoding: utf-8
require_relative 'spec_helper'
require 'yaml'
require 'awesome_print'

require 'libis/tools/config_file'

require 'libis/services/rosetta/producer_handler'

describe 'Rosetta Producer Service' do

  let(:credentials) {Libis::Tools::ConfigFile.new File.join(File.dirname(__FILE__), 'credentials-test.yml')}
  # noinspection RubyResolve
  let(:admin) {credentials.admin}
  # noinspection RubyResolve
  let(:admin_usr) {admin.user}
  # noinspection RubyResolve
  let(:admin_uid) {admin.user_id}
  # noinspection RubyResolve
  let(:admin_pwd) {admin.password}
  # noinspection RubyResolve
  let(:admin_ins) {admin.institute}

  let(:contact_info) {{user_id: credentials.contact.user_id, name: 'Test User'}}
  # noinspection RubyResolve
  subject(:producer_handler) do
    handler = Libis::Services::Rosetta::ProducerHandler.new credentials.rosetta_url,
                                                            log: credentials.debug,
                                                            log_level: credentials.debug_level
    handler
  end

  before :each do
    # noinspection RubyResolve
    producer_handler.authenticate(credentials.admin.user, credentials.admin.password, credentials.admin.institute)
  end

  context 'user info' do
    # noinspection RubyBlockToMethodReference
    let(:user_id) {admin_uid}

    # noinspection RubyBlockToMethodReference
    let(:user_name) {admin_usr}

    it 'gets user id' do
      result = producer_handler.user_id(user_name)
      expect(result).to eq user_id
    end

    it 'checks user id' do
      result = producer_handler.is_user?(user_name)
      expect(result).to be_truthy

      result = producer_handler.is_user?(user_id)
      expect(result).to be_falsey

      result = producer_handler.is_user?('user_that_does_not_exist')
      expect(result).to be_falsey
    end

  end

  context 'producer' do

    let(:producer_id) {credentials.producer.id}
    let(:producer_data) {credentials.producer.data.to_hash}
    # noinspection RubyArgCount
    let(:producer_info) {::Libis::Services::Rosetta::Producer.new(producer_data).to_hash}
    let(:updated_info) {{email: 'nomail@mail.com', telephone_2: '0032 16 32 22 22'}}
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
      # ap result
      expect(result).not_to be_nil
      expect(result.to_hash).to match producer_data
      expect(producer_data).to match result.to_hash
    end

    it 'create producer' do
      result = producer_handler.new_producer(new_producer_info)
      expect(result).not_to be_nil
      expect(result).to match(/^\d+$/)
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

  # Disabled section. Rosett bugs and insuficient documentation cause these tests to fail.

  context 'producer agent' do

    let(:new_agent_data) { {
        user_name: 'testagent2',
        first_name: 'Test',
        last_name: 'Agent',
        email_address: 'test@mail.com',
        street: 'Willem de Croylaan 54',
        city: 'Heverlee',
        zip: '3001',
        country: 'Belgium',
        telephone_1: '0032 16 32 22 66',
        user_group: 'producer_agents'
    }}
    let(:new_agent) {
      data = new_agent_data.dup
      # data[:password] = data[:password_verify] = 'abc123ABC'
      # noinspection RubyArgCount
      Libis::Services::Rosetta::ProducerAgent.new(data).to_hash
    }

    # noinspection RubyResolve
    let(:agent_data) {credentials.producer_agent.data.to_hash}
    # noinspection RubyArgCount
    let(:agent) {::Libis::Services::Rosetta::User.new(agent_data)}
    # noinspection RubyResolve
    let(:agent_id) {credentials.producer_agent.user_id}
    # noinspection RubyResolve
    let(:agent_ins) {credentials.producer_agent.institute}

    def new_agent_id(val = nil)
      $new_agent_id = val.to_i if val
      $new_agent_id
    end

    it 'get info' do
      result = producer_handler.agent(agent_id)
      expect(result).not_to be_nil
      # ap result.to_hash
      # ap agent_data
      expect(result.to_hash).to match agent_data
    end

    # DISABLED: Rosetta API does noet work anymore as expected
    
    # it 'create' do
    #   result = producer_handler.new_agent new_agent
    #   expect(result).not_to be_nil
    #   expect(result).to match(/^\d+$/)
    #   new_agent_id result
    # end

    # it 'get info' do
    #   result = producer_handler.agent(new_agent_id)
    #   expect(result).not_to be_nil
    #   expect(result.to_hash).to match new_agent_data
    # end

    # it 'update info' do
    #   # update data
    #   updated_agent = new_agent_data.dup
    #   updated_agent[:email_address] = 'other@mail.com'
    #   result = producer_handler.agent(new_agent_id, updated_agent)
    #   expect(result).not_to be_nil
    #   expect(result).to eq new_agent_id

    #   # retrieve updated data
    #   result = producer_handler.agent(new_agent_id)
    #   expect(result).not_to be_nil
    #   expect(result.to_hash).to match updated_agent
    # end


    # it 'delete' do
    #   result = producer_handler.delete_agent new_agent_id
    #   expect(result).not_to be_nil
    #   expect(result).to eq new_agent_id
    #   result = producer_handler.agent(new_agent_id)
    #   expect(result).to be_nil
    # end

    it 'get producers' do
      result = producer_handler.agent_producers agent_id, agent_ins
      expect(result).not_to be_nil
      # noinspection RubyResolve
      expect(result).to eq [{id: credentials.producer.id, description: credentials.producer.data.authoritative_name}]
    end

  end

  context 'contact' do

    let(:contact_id) {credentials.contact.user_id}
    let(:contact_info) {credentials.contact.data.to_hash}
    let(:new_contact) {
      # noinspection RubyArgCount
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
    let(:updated_info) {{email_address: 'new_contact@mail.com', telephone_2: '0032 16 32 22 22'}}
    let(:updated_contact) {new_contact.to_hash.dup.merge(updated_info)}

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
      expect(result).to match(/^\d+$/)
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