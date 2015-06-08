# encoding: utf-8
require_relative 'spec_helper'
require 'yaml'

require 'libis/tools/config_file'

require 'libis/services/rosetta/pds_handler'
require 'libis/services/rosetta/deposit_handler'

describe 'Rosetta Deposit Service' do

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

  subject(:deposit_handler) do
    # noinspection RubyResolve
    Libis::Services::Rosetta::DepositHandler.new credentials.rosetta_url, log: true, log_level: :debug
  end

  before :each do
    deposit_handler.pds_handle = handle
  end

  it 'should get list of deposits' do

    deposits = deposit_handler.get_by_submit_flow('01/01/2010', '31/12/2015', '2', status: 'All')

    expect(deposits).to eq [
                               {
                                   deposit_activity_id: '55401',
                                   creation_date: '02/12/2014',
                                   status: 'Approved',
                                   title: 'Test DAV',
                                   producer_agent_id: '100',
                                   submit_date: '02/12/2014',
                                   update_date: '02/12/2014',
                                   sip_id: '54854',
                                   producer_id: '35202',
                                   sip_reason: nil
                               }
                           ]
  end

  it 'should get list of deposits' do

    deposits = deposit_handler.get_by_submit_date('01/01/2010', '31/12/2015', status: 'Approved')

    expect(deposits).to eq []
  end

end