# encoding: utf-8
require_relative 'spec_helper'

require 'libis/tools/config_file'

require 'libis/services/rosetta/pds_handler'
require 'libis/services/rosetta/collection_handler'

class String
  def unindent
    gsub(/^#{scan(/^\s*/).min_by { |l| l.length }}/, '')
  end
end

describe 'Rosetta Producer Service' do

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

  let(:collection_info) { Libis::Services::Rosetta::CollectionHandler::CollectionInfo.new collection_data }

  let(:parent_name) { 'Test Collection' }
  let(:parent_id) { 20683598 }

  # noinspection RubyResolve
  subject(:collection_service) do
    collection_service = Libis::Services::Rosetta::CollectionHandler.new credentials.rosetta_url, log: true, log_level: :debug
    collection_service.pds_handle = handle
    collection_service
  end

  context 'existing collections' do

    let(:collection_data) { {
        id: 20683672,
        name: 'another collection',
        parent_id: parent_id,
        md_dc: {
            mid: '81908',
            type: 'descriptive',
            sub_type: 'dc',
            content: <<-STR.unindent.strip
            <?xml version="1.0" encoding="UTF-8"?>\n<dc:record xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><dc:title>My pictures</dc:title><dcterms:created>2014-01-01 10:00</dcterms:created></dc:record>
            STR
        },
        md_source: [],
        navigate: nil,
        publish: nil,
        external_id: '9999',
        external_system: 'CollectiveAccess'
    } }

    it 'get collection by ID' do
      coll_info = collection_service.get(collection_data[:id])
      expect(coll_info.to_hash).to eq collection_data
    end

    it 'get collection by name' do
      coll_info = collection_service.find(parent_name + '/' + collection_data[:name])
      expect(coll_info.to_hash).to eq collection_data
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
            <?xml version="1.0" encoding="UTF-8"?>\n<dc:record xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><dc:title>Something new to test</dc:title><dcterms:created>2015-06-25 10:00</dcterms:created></dc:record>
            STR
        },
        md_source: [],
        navigate: nil,
        publish: nil,
        external_id: '12345',
        external_system: 'Scope'
    } }

    let(:new_collection) { collection_service.find(parent_name + '/' + collection_data[:name]) }

    let(:new_collection_data) {
      new_collection_data = collection_data.dup
      new_collection_data[:id] = new_collection.id
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
      collection_data[:publish] = true
      collection_data[:navigate] = true
      new_collection_id = collection_service.create(collection_data)
      expect(new_collection_id).not_to be_nil
      expect(new_collection_id).to be_a String
    end

    it 'retrieve new collection' do
      expect(new_collection.to_hash).to eq new_collection_data
    end

    it 'update new collection' do
      result = collection_service.update(updated_collection_data)
      expect(result).to be {}
      expect(updated_collection.to_hash).to eq updated_collection_data
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