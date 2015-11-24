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
    {name:'TESTINS-collections', spec: 'TESTINS-collections'}
  }

  let(:expected_collections) {
    [
        'My pictures',
        'Test Collection',
    ]
  }

  let(:expected_records) {
    [
        {
            id: 'oai:d4I1-pubam:IE403595',
        }
    ]
  }

  it 'should get set list' do
    sets = oai_handler.sets
    expect(sets).to include(expected_sets)
  end

  it 'should get list of collections' do
    status = {}
    collections = oai_handler.collections('TESTINS', status)
    check_container expected_collections, collections
  end

  it 'should get list of records' do
    status = {}
    records = oai_handler.records('test_data', status)
    check_container(expected_records, records)
  end

end