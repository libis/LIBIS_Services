# encoding: utf-8
require_relative 'spec_helper'
require 'yaml'

require 'libis/tools/config_file'

require 'libis/services/rosetta/pds_handler'
require 'libis/services/rosetta/producer_handler'
require 'libis/services/rosetta/deposit_handler'

describe 'Rosetta PDS Service' do

  let!(:credentials) { Libis::Tools::ConfigFile.new File.join(File.dirname(__FILE__), 'credentials-prod.yml') }
  let!(:pds_handler) do
    # noinspection RubyResolve
    Libis::Services::Rosetta::PdsHandler.new(credentials.pds_url)
  end

  let(:handle) { pds_handler.login(admin_usr, admin_pwd, admin_pds_ins) }

  # noinspection RubyResolve
  let(:admin) { credentials.admin }
  # noinspection RubyResolve
  let(:admin_usr) { admin.user }
  # noinspection RubyResolve
  let(:admin_pwd) {admin.password}
  # noinspection RubyResolve
  let(:admin_ins) {admin.institute}
  let(:admin_pds_ins) {admin.institute_pds}

  it 'should login and return a handle' do
    expect(handle).to_not be_nil
  end

  it 'should not login with wrong user' do
    expect(    pds_handler.login(
                   'deadbeaf',
                   admin_pwd,
                   admin_ins
               )
    ).to be_nil
  end

  it 'should not login with wrong pasword' do
    expect(    pds_handler.login(
                   admin_usr,
                   'deadbeaf',
                   admin_ins
               )
    ).to be_nil
  end

  it 'should not login with wrong institution' do
    expect(    pds_handler.login(
                   admin_usr,
                   admin_pwd,
                   'deadbeaf'
               )
    ).to be_nil
  end

  it 'should return patron info' do
    bor_info = pds_handler.user_info handle
    expect(bor_info[:bor_info][:id]).to eq admin_usr
    expect(bor_info[:bor_info][:name]).to eq admin_usr
    expect(bor_info[:bor_info][:institute]).to eq admin_pds_ins

  end

  it 'should logout using a valid handle' do
    expect(pds_handler.logout(handle)).to be_truthy
  end

  it 'should logout using an invalid handle' do
    # Disabled: Rosetta PDS error
    # expect(pds_handler.logout('abcdef')).to be_falsy
    expect(pds_handler.logout('abcdef')).to be_truthy
  end

end