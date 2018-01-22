# encoding: utf-8
require_relative 'spec_helper'
require 'yaml'
require 'awesome_print'
require 'pp'

require 'libis/tools/config_file'
require 'libis/services/rosetta/pds_handler'
require 'libis/services/rosetta/ie_handler'

require_relative 'ie_data'
describe 'Rosetta IE Service' do

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

  subject(:ie_handler) do
    # noinspection RubyResolve
    Libis::Services::Rosetta::IeHandler.new credentials.rosetta_url,
                                            log: credentials.debug,
                                            log_level: credentials.debug_level
  end

  before :each do
    ie_handler.pds_handle = handle
  end

  it 'should get IE info' do

    mets = ie_handler.get_mets('IE403595')
    expect(mets).not_to be_nil
    ap mets
    expect(mets).to deep_include(expected_mets)
    # check_container expected_mets, mets
  end

  it 'should get IE metadata' do

    metadata = ie_handler.get_metadata('IE403595')
    expect(metadata).not_to be_nil
    expect(metadata).to deep_include(expected_ies)
    # check_container(expected_ies, metadata)
  end

end