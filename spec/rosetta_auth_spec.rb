# encoding: utf-8
require_relative 'spec_helper'
require 'yaml'

require 'libis/tools/config_file'

require 'libis/services/rosetta/pds_handler'
require 'libis/services/rosetta/producer_handler'

describe 'Rosetta Services' do

  def protected_call(handler, producer_id, producer_name)
    result = handler.producer(producer_id)
    expect(result.authoritative_name).to eq producer_name
  end

  def failed_protected_call(handler, producer_id)
    expect {handler.producer(producer_id)}.to raise_error(Libis::Services::ServiceError, /^Incorrect username or password/)
  end

  def invalid_protected_call(handler, producer_id)
    expect {handler.producer(producer_id)}.to raise_error(Libis::Services::ServiceError)
  end

  let!(:credentials) {Libis::Tools::ConfigFile.new File.join(File.dirname(__FILE__), 'credentials-test.yml')}

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

  let(:bad_cred) { 'deadbeaf' }

  describe 'basic authentication' do

    let(:handler) do
      # noinspection RubyResolve
      handler = Libis::Services::Rosetta::ProducerHandler.new(
          credentials.rosetta_url,
          # log: credentials.debug,
          # log_level: credentials.debug_level
      )
      handler
    end

    let(:user_name) {admin_usr}
    let(:user_id) {admin_uid}
    let(:producer_id) {credentials.producer.id}
    let(:producer_name) {credentials.producer.data.authoritative_name}

    it 'should allow protected call with correct login' do
      handler.authenticate(admin_usr, admin_pwd, admin_ins)
      protected_call(handler, producer_id, producer_name)
    end

    it 'should fail protected call with wrong password' do
      handler.authenticate(admin_usr, bad_cred, admin_ins)
      failed_protected_call(handler, producer_id)
    end

    it 'should fail protected call with wrong institution' do
      handler.authenticate(admin_usr, admin_pwd, bad_cred)
      failed_protected_call(handler, producer_id)
    end

    it 'should fail protected call with wrong user name' do
      handler.authenticate(bad_cred, admin_pwd, admin_ins)
      failed_protected_call(handler, producer_id)
    end

  end

  describe 'PDS authentication' do

    let(:handler) do
      # noinspection RubyResolve
      handler = Libis::Services::Rosetta::ProducerHandler.new(
          credentials.rosetta_url,
          # log: credentials.debug,
          # log_level: credentials.debug_level
      )
      handler
    end

    let(:user_name) {admin_usr}
    let(:user_id) {admin_uid}
    let(:producer_id) {credentials.producer.id}
    let(:producer_name) {credentials.producer.data.authoritative_name}

    let!(:pds_handler) do
      # noinspection RubyResolve
      Libis::Services::Rosetta::PdsHandler.new(credentials.pds_url)
    end

    describe 'with correct credentials' do
      let(:handle) {pds_handler.login(admin_usr, admin_pwd, admin_ins)}

      it 'should login and return a handle' do
        expect(handle).to_not be_nil
      end

      it 'should return patron info' do
        bor_info = pds_handler.user_info handle
        expect(bor_info[:bor_info][:id]).to eq admin_usr
        expect(bor_info[:bor_info][:name]).to eq admin_usr
        expect(bor_info[:bor_info][:institute]).to eq admin_ins

      end

      it 'should allow protected call' do
        handler.pds_handle = handle
        protected_call(handler, producer_id, producer_name)
      end

      it 'should logout using a valid handle' do
        expect(pds_handler.logout(handle)).to be_truthy
      end

    end

    describe 'with wrong user name' do
      let(:handle) {pds_handler.login(bad_cred, admin_pwd, admin_ins)}

      it 'should not login' do
        expect(handle).to be_nil
      end

      it 'should fail protected call' do
        handler.pds_handle = handle
        invalid_protected_call(handler, producer_id)
      end

      it 'should logout using a invalid handle' do
        expect(pds_handler.logout(handle)).to be_truthy
      end

    end

    describe 'with wrong password' do
      let(:handle) {pds_handler.login(admin_usr, bad_cred, admin_ins)}

      it 'should not login' do
        expect(handle).to be_nil
      end

      it 'should fail protected call' do
        handler.pds_handle = handle
        invalid_protected_call(handler, producer_id)
      end

      it 'should logout using a invalid handle' do
        expect(pds_handler.logout(handle)).to be_truthy
      end

    end

    describe 'with wrong institution' do
      let(:handle) {pds_handler.login(admin_usr, admin_pwd, bad_cred)}


      it 'should not login' do
        expect(handle).to be_nil
      end

      it 'should fail protected call' do
        handler.pds_handle = handle
        invalid_protected_call(handler, producer_id)
      end

      it 'should logout using a invalid handle' do
        expect(pds_handler.logout(handle)).to be_truthy
      end

    end

  end

end