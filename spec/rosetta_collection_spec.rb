# encoding: utf-8
require_relative 'spec_helper'

require 'libis/tools/config_file'
require 'libis/tools/extend/hash'

require 'libis/services/rosetta/pds_handler'
require 'libis/services/rosetta/collection_handler'

require 'rspec/matchers'
require 'equivalent-xml'

class String
  def unindent
    gsub(/^#{scan(/^\s*/).min_by { |l| l.length }}/, '')
  end
end

RSpec::Matchers.define(:match_collection) do |target_collection|
  match do |actual_collection|
    actual_md = actual_collection.delete(:md_dc)
    target_md = target_collection.delete(:md_dc)
    expect(actual_collection).to include(target_collection)
    actual_xml = actual_md.delete(:content)
    target_xml = target_md.delete(:content)
    expect(actual_md).to include(target_md)
    match_xml(actual_xml, target_xml)
  end

  def match_xml(doc1, doc2)
    doc1 = ::Nokogiri::XML(doc1) if doc1.is_a?(String)
    doc2 = ::Nokogiri::XML(doc2) if doc2.is_a?(String)
    expect(doc1.root).to be_equivalent_to(doc2.root)
  end

end


describe 'Rosetta Collection Service' do

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

  let(:collection_info) { Libis::Services::Rosetta::CollectionInfo.new collection_data }

  let(:parent_name) { 'Test Collection' }
  let(:parent_id) { '23082369' }

  # noinspection RubyResolve
  subject(:collection_service) do
    collection_service = Libis::Services::Rosetta::CollectionHandler.new credentials.rosetta_url,
                                                                         log: credentials.debug,
                                                                         log_level: credentials.debug_level
    collection_service.pds_handle = handle
    collection_service
  end

  context 'existing collections' do

    let(:collection_data) { {
        id: '23082442',
        name: 'another collection',
        parent_id: parent_id,
        md_dc: {
            mid: '212362',
            type: 'descriptive',
            sub_type: 'dc',
            content: <<-STR.unindent.strip
            <?xml version="1.0" encoding="UTF-8"?>
              <dc:record xmlns:dc="http://purl.org/dc/elements/1.1/"
                         xmlns:dcterms="http://purl.org/dc/terms/"
                         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
              <dc:title>My pictures</dc:title>
              <dcterms:created>2014-01-01 10:10:10</dcterms:created>
            </dc:record>
            STR
        },
        md_source: [],
        navigate: true,
        publish: true,
        external_id: '5555',
        external_system: 'CollectiveAccess'
    } }

    it 'get collection by ID' do
      coll_info = collection_service.get(collection_data[:id])
      expect(coll_info.to_hash).to match_collection(collection_data)
    end

    it 'get collection by name' do
      coll_info = collection_service.find(parent_name + '/' + collection_data[:name])
      expect(coll_info.to_hash).to match_collection(collection_data)
    end
  end

  context 'collections CRUD' do

    let(:collection_data) { {
        name: 'My new test collection',
        parent_id: parent_id,
        md_dc: {
            type: 'descriptive',
            sub_type: 'dc',
            content: <<-STR.unindent.strip
            <?xml version="1.0" encoding="UTF-8"?>
              <dc:record xmlns:dc="http://purl.org/dc/elements/1.1/"
                         xmlns:dcterms="http://purl.org/dc/terms/"
                         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
              <dc:title>Something new to test</dc:title>
              <dcterms:created>2015-06-25 10:00</dcterms:created>
            </dc:record>
            STR
        },
        md_source: [],
        navigate: true,
        publish: false,
        external_id: '12345',
        external_system: 'Scope'
    } }

    let(:new_collection) { collection_service.find(parent_name + '/' + collection_data[:name]) }

    let(:new_collection_data) {
      new_collection_data = {id: new_collection.id}
      new_collection_data.reverse_merge!(collection_data)
      new_collection_data[:md_dc][:mid] = new_collection.md_dc.mid
      new_collection_data
    }

    let(:updated_name) { 'Stupid text' }

    let(:updated_collection) { collection_service.find(parent_name + '/' + updated_name) }

    let(:updated_collection_data) {
      updated_collection_data = new_collection_data.dup
      updated_collection_data[:name] = updated_name
      updated_collection_data
    }


    it 'create new collection' do
      new_collection_id = collection_service.create(collection_data)
      expect(new_collection_id).not_to be_nil
      expect(new_collection_id).to be_a String
      expect(new_collection_id).to eq new_collection.id
    end

    it 'retrieve new collection' do
      expect(new_collection.to_hash).to match_collection(new_collection_data)
    end

    it 'update new collection' do
      result = collection_service.update(updated_collection_data)
      expect(result).to be {}
      expect(updated_collection.to_hash).to match_collection(updated_collection_data)
    end

    it 'delete new collection' do
      result = collection_service.delete(updated_collection.id)
      expect(result).to be {}
    end

  end

  context 'check errors' do

    it 'not authorized' do
      collection_service.pds_handle = 'foobar'
      expect do
        collection_service.create({name: 'foo'})
      end.to raise_error(Libis::Services::SoapError, /user_authorize_exception.*Invalid PDS Handle Number:foobar/)
    end

    it 'invalid collection info' do
      expect do
        collection_service.create({name: 'foo', parent_id: 0})
      end.to raise_error(Libis::Services::SoapError, /invalid_collection_info_exception.*Invalid Parent Id: 0/)
    end

    it 'not found by id' do
      expect do
        collection_service.get(0)
      end.to raise_error(Libis::Services::SoapError, /no_collection_found_exception.*collection with id: 0 not found/)
    end

    it 'not found by name' do
      expect do
        collection_service.find('foo')
      end.to raise_error(Libis::Services::SoapError, /no_collection_found_exception.*collection with name: foo not found/)
    end

  end

end