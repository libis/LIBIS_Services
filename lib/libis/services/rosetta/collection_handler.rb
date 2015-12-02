# encoding: utf-8
require 'virtus'

require 'libis/tools/extend/hash'
require_relative 'collection_info'
require_relative 'client'

module Libis
  module Services
    module Rosetta

      class CollectionHandler < Libis::Services::Rosetta::Client


        def initialize(base_url = 'http://depot.lias.be', options = {})
          super 'repository', 'CollectionWebServices', {url: base_url}.merge(options)
        end

        def get(id)
          request_object :get_collection_by_id, Rosetta::CollectionInfo, pds_handle: @pds_handle, collection_id: id
        end

        def find(path)
          request_object :get_collection_by_name, Rosetta::CollectionInfo, pds_handle: @pds_handle, collection_path: path
        end

        def create(collection_info)
          collection_info = collection_info.to_hash.cleanup if collection_info.is_a? CollectionInfo
          call :create_collection, pds_handle: @pds_handle, collection: collection_info
        end

        def delete(id)
          call :delete_collection, pds_handle: @pds_handle, collection_id: id
        end

        def update(collection_info)
          collection_info = collection_info.attributes if collection_info.is_a? CollectionInfo
          call :update_collection, pds_handle: @pds_handle, collection: collection_info
        end

      end

    end
  end
end