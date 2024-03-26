# encoding: utf-8
require_relative 'spec_helper'

require 'libis/tools/config_file'
require 'libis/tools/extend/symbol'
require 'libis/services/rosetta/oai_pmh'

describe 'Rosetta OAI-PMH Service' do

  let(:credentials) { Libis::Tools::ConfigFile.new File.join(File.dirname(__FILE__), 'credentials-test.yml'), debug: true }

  subject(:oai_handler) do
    # noinspection RubyResolve
    Libis::Services::Rosetta::OaiPmh.new credentials.rosetta_url
  end

  let(:expected_identify) {
    {
      repository_name: 'LIBIS Teneo Sandbox Repository',
      base_url: "#{credentials.rosetta_url}/oaiprovider/request"
    }
  }

  let(:expected_metadata_formats) {
    [ 'oai_dc' ]
  }

  let(:expected_sets) {
    [
      'TESTINS-collections',
      'INS00-collections'
    ]
  }

  let(:expected_collections) {
    [
        'E-periodieken',
        'Parochiebladen',
        'Kerk en leven. Puurs (4635)',
    ]
  }

  let(:expected_identifiers) {
    [ 'oai:sandbox.teneo.libis.be:IE1000']
  }

  let(:expected_records) {
    [
        {
          header: {identifier: 'oai:sandbox.teneo.libis.be:IE1000'},
          metadata: {
            'metadata' => {
              'oai_dc:dc' => {
                'dc:title' => 'Test'
              }
            }
          }
        }
    ]
  }

  it 'should identify' do
    id = oai_handler.identify
    expect(id).to deep_include(expected_identify)
  end

  it 'should get metata formats' do
    formats = oai_handler.metadata_formats
    expect(formats[:entries].map(&:dig.with(:prefix)).compact).to deep_include(expected_metadata_formats)
  end

  it 'should get set list' do
    sets = oai_handler.sets
    expect(sets[:entries].map(&:dig.with(:name)).compact).to deep_include(expected_sets)
  end

  it 'should get list of collections' do
    collections = oai_handler.collections('KADOC')
    expect(collections[:entries].map(&:dig.with(:metadata, 'metadata', 'oai_dc:dc', 'dc:title')).compact).to deep_include(expected_collections)
  end

  it 'should get list of identifiers' do
    ids = oai_handler.identifiers(set: 'test_data', from: '2020-01-01')
    expect(ids[:entries].map(&:dig.with(:identifier)).compact).to deep_include(expected_identifiers)
  end

  it 'should get list of records' do
    records = oai_handler.records(set: 'test_data', from: '2020-01-01')
    expect(records[:entries]).to deep_include(expected_records)
  end

end
