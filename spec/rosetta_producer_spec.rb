# encoding: utf-8
require_relative 'spec_helper'
require 'yaml'

require 'libis/tools/config_file'

require 'libis/services/rosetta/pds_handler'
require 'libis/services/rosetta/producer_handler'

describe 'Rosetta Producer Service' do

  let(:credentials) { Libis::Tools::ConfigFile.new File.join(File.dirname(__FILE__), 'credentials.yml') }
  let(:pds_handler) do
    # noinspection RubyResolve
    Libis::Services::Rosetta::PdsHandler.new(credentials.pds_url)
  end

  let(:handle) do
    # noinspection RubyResolve
    pds_handler.login(
        credentials.admin.user,
        credentials.admin.password,
        credentials.admin.institute
    )
  end

  let(:contact_info) { {user_id: '123'} }

  # noinspection RubyResolve
  subject(:producer_handler) do
    Libis::Services::Rosetta::ProducerHandler.new credentials.rosetta_url, log: true, log_level: :debug
  end

  before :each do
    producer_handler.pds_handle = handle
  end

  # noinspection RubyResolve
  it 'gets user id' do
    result = producer_handler.user_id(credentials.admin.user)
    expect(result).to eq credentials.admin.user_id
  end

  # noinspection RubyResolve
  it 'checks user id' do
    result = producer_handler.is_user?(credentials.admin.user)
    expect(result).to be_truthy

    result = producer_handler.is_user?(credentials.admin.user_id)
    expect(result).to be_truthy

    result = producer_handler.is_user?('user_that_does_not_exist')
    expect(result).to be_falsey
  end

  context 'producer' do

    # noinspection RubyResolve
    it 'get info' do
      result = producer_handler.producer(credentials.producer.user_id)
      expect(result).to eq credentials.producer.to_hash
    end

    it 'update info' do
      result = producer_handler.producer(credentials.producer.user_id, '<email>test@mail.com</email>')
      expect(result).to eq credentials.producer.to_hash
    end

    it 'create' do
      result = producer_handler.producer = '<email>test@mail.com</email>'
      expect(result).to eq credentials.producer.to_hash
    end

    it 'delete' do
      result = producer_handler.producer! '123456789'
      expect(result).to eq credentials.producer.to_hash
    end

    it 'material flows' do
      result = producer_handler.material_flows credentials.producer.user_id
      expect(result).to eq credentials.to_h['material_flow']
    end

  end

  context 'producer agent' do

    it 'get info' do
      result = producer_handler.agent(credentials.agent.user_id)
      expect(result).to eq credentials.agent.to_hash
    end

    it 'update info' do
      result = producer_handler.agent(credentials.agent.user_id, '<email>test@mail.com</email>')
      expect(result).to eq credentials.agent.to_hash
    end

    it 'create' do
      result = producer_handler.agent = '<email>test@mail.com</email>'
      expect(result).to eq credentials.agent.to_hash
    end

    it 'delete' do
      result = producer_handler.agent! '123456789'
      expect(result).to eq credentials.agent.to_hash
    end

    # noinspection RubyResolve
    it 'get producers' do
      result = producer_handler.agent_producers credentials.agent.user_id, credentials.agent.institute
      expect(result).to eq [credentials.producer.user_id]
    end

  end

  context 'contact' do

    it 'get info' do
      result = producer_handler.contact(credentials.contact.user_id)
      expect(result).to eq credentials.contact.to_hash
    end

    it 'update info' do
      result = producer_handler.producer(credentials.contact.user_id, '<email>test@mail.com</email>')
      expect(result).to eq credentials.contact.to_hash
    end

    it 'create' do
      result = producer_handler.contact = '<email>test@mail.com</email>'
      expect(result).to eq credentials.contact.to_hash
    end

    it 'delete' do
      result = producer_handler.contact! '123456789'
      expect(result).to eq credentials.contact.to_hash
    end

  end

end