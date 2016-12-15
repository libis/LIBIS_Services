# encoding: utf-8
require_relative 'spec_helper'
require 'yaml'

require 'libis/tools/config_file'
require 'libis/services/rosetta/sip_handler'

describe 'Rosetta SIP Service' do

  let(:credentials) { Libis::Tools::ConfigFile.new File.join(File.dirname(__FILE__), 'credentials-test.yml') }

  subject(:sip_handler) do
    # noinspection RubyResolve
    Libis::Services::Rosetta::SipHandler.new credentials.rosetta_url,
                                             log: credentials.debug,
                                             log_level: credentials.debug_level
  end

  let(:expected_info) {
    { module: 'PER', stage: 'Finished', status: 'FINISHED' }
  }

  let(:expected_ies) { [{pid: 'IE433994'}] }

  it 'should get SIP info' do

    sip_info = sip_handler.get_info(55010)
    expect(sip_info).not_to be_nil
    expect(sip_info.to_hash).to match expected_info
  end

  it 'should get list of IEs in the SIP' do

    ies = sip_handler.get_ies(55010)
    expect(ies).not_to be_nil
    expect(ies.map(&:to_h)).to match_array expected_ies
  end

end