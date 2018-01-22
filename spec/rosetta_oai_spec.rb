# encoding: utf-8
require_relative 'spec_helper'

require 'libis/tools/config_file'
require 'libis/services/rosetta/oai_pmh'

describe 'Rosetta OAI-PMH Service' do

  let(:credentials) { Libis::Tools::ConfigFile.new File.join(File.dirname(__FILE__), 'credentials-test.yml'), debug: true }

  subject(:oai_handler) do
    # noinspection RubyResolve
    Libis::Services::Rosetta::OaiPmh.new credentials.rosetta_url
  end

  let(:expected_sets) {
    [
        {name:'TESTINS-collections', spec: 'TESTINS-collections'}
    ]
  }

  let(:expected_collections) {
    [
        'Kerk & Leven',
        'Kerk en leven. Bisdom Antwerpen (0991).',
    ]
  }

  let(:expected_records) {
    [
        {
            id: 'oai:d4I1-pubam:IE405650',
        }
    ]
  }

  it 'should get set list' do
    sets = oai_handler.sets
    expect(sets[:entries]).to deep_include(expected_sets)
  end

  it 'should get list of collections' do
    status = {}
    collections = oai_handler.collections('TESTINS', status)
    expect(collections).to deep_include(expected_collections)
  end

  it 'should get list of records' do
    status = {}
    records = oai_handler.records('test_data', status)
    expect(records).to deep_include(expected_records)
  end

end