# encoding: utf-8
require_relative 'spec_helper'
require 'yaml'

require 'libis/tools/config_file'

require 'libis/services/rosetta/pds_handler'
require 'libis/services/rosetta/producer_handler'
require 'libis/services/rosetta/deposit_handler'

describe 'Rosetta PDS Service' do

  let!(:credentials) { Libis::Tools::ConfigFile.new File.join(File.dirname(__FILE__), 'credentials.yml') }
  let!(:pds_handler) do
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

  it 'should login and return a handle' do
    expect(handle).to_not be_nil
  end

  # noinspection RubyResolve
  it 'should return patron info' do
    bor_info = pds_handler.user_info handle
    expect(bor_info[:bor_info][:id]).to eq credentials.admin.user
    expect(bor_info[:bor_info][:name]).to eq credentials.admin.user
    expect(bor_info[:bor_info][:institute]).to eq credentials.admin.institute

  end

  it 'should logout using a valid handle' do
    expect(pds_handler.logout(handle)).to be_truthy
  end

  it 'should logout using an invalid handle' do
    expect(pds_handler.logout('abcdef')).to be_truthy
  end

end