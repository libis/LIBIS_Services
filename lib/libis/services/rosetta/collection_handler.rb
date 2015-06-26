# encoding: utf-8
require 'virtus'

require 'libis/tools/extend/hash'
require_relative 'client'

module Libis
  module Services
    module Rosetta

      class CollectionHandler < Libis::Services::Rosetta::Client

        class MetaData
          # noinspection RubyResolve
          include Virtus.model

          attribute :mid, String
          attribute :type, String
          attribute :sub_type, String
          attribute :content, String
        end

        class CollectionInfo
          # noinspection RubyResolve
          include Virtus.model

          attribute :id, Integer
          attribute :name, String
          attribute :parent_id, Integer
          attribute :md_dc, MetaData
          attribute :md_source, Array[MetaData]
          attribute :navigate, Boolean
          attribute :publish, Boolean
          attribute :external_id, String
          attribute :external_system, String

          def to_hash
            result = self.attributes
            result[:md_dc] = result[:md_dc].attributes if result[:md_dc]
            result[:md_source] = result[:md_source].map { |md| md.attributes }
            result
          end

        end

        def initialize(base_url = 'http://depot.lias.be', options = {})
          super 'repository', 'CollectionWebServices', {url: base_url}.merge(options)
        end

        def get(id)
          reply = do_request :get_collection_by_id, pds_handle: @pds_handle, collection_id: id
          CollectionInfo.new reply[:return]
        end

        def find(path)
          reply = do_request :get_collection_by_name, pds_handle: @pds_handle, collection_path: path
          CollectionInfo.new reply[:return]
        end

        def create(collection_info)
          collection_info = collection_info.attributes if collection_info.is_a? CollectionInfo
          reply = do_request :create_collection, pds_handle: @pds_handle, collection: collection_info
          reply[:return]
        end

        def delete(id)
          do_request :delete_collection, pds_handle: @pds_handle, collection_id: id
        end

        def update(collection_info)
          collection_info = collection_info.attributes if collection_info.is_a? CollectionInfo
          do_request :update_collection, pds_handle: @pds_handle, collection: collection_info
        end

        protected

        def result_parser(response, options = {})
          puts response
          response
        end

      end

    end
  end
end