# encoding: utf-8
require_relative 'spec_helper'
require 'yaml'

require 'libis/tools/config_file'

require 'libis/services/rosetta/pds_handler'
require 'libis/services/rosetta/deposit_handler'

describe 'Rosetta Deposit Service' do

  let(:credentials) { Libis::Tools::ConfigFile.new File.join(File.dirname(__FILE__), 'credentials-test.yml') }
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

  subject(:deposit_handler) do
    # noinspection RubyResolve
    Libis::Services::Rosetta::DepositHandler.new credentials.rosetta_url,
                                                 log: credentials.debug,
                                                 log_level: credentials.debug_level
  end

  before :each do
    deposit_handler.pds_handle = handle
  end

  it 'should get list of deposits by date' do

    deposits = deposit_handler.get_by_submit_date('13/10/2015', '13/10/2015', status: 'All')

    # noinspection RubyResolve
    expect(deposits.to_hash[:records]).to eq [
                                                 {
                                                 #     deposit_activity_id: 55662,
                                                 #     creation_date: '13/10/2015',
                                                 #     status: 'Approved',
                                                 #     title: 'test ingest - 1',
                                                 #     producer_agent_id: credentials.admin.user_id.to_i,
                                                 #     submit_date: '13/10/2015',
                                                 #     update_date: '13/10/2015',
                                                 #     sip_id: 55010,
                                                 #     producer_id: 23106349,
                                                 #     sip_reason: 'Files Rejected'
                                                 }
                                             ]
  end

  it 'should get list of deposits by date and material flow' do

    # noinspection RubyResolve
    deposits = deposit_handler.get_by_submit_flow('13/10/2015', '13/10/2015', credentials.material_flow.manual.id, status: 'All')

    # noinspection RubyResolve
    expect(deposits.to_hash[:records]).to eq [
                                                 {
                                                 #     deposit_activity_id: 55662,
                                                 #     creation_date: '13/10/2015',
                                                 #     status: 'Approved',
                                                 #     title: 'test ingest - 1',
                                                 #     producer_agent_id: credentials.admin.user_id.to_i,
                                                 #     submit_date: '13/10/2015',
                                                 #     update_date: '13/10/2015',
                                                 #     sip_id: 55010,
                                                 #     producer_id: 23106349,
                                                 #     sip_reason: 'Files Rejected'
                                                 }
                                             ]
  end


end