# encoding: utf-8
require 'virtus'

module Libis
  module Services
    module Rosetta

      class CollectionInfo
        # noinspection RubyResolve
        include Virtus.model

        class MetaData
          # noinspection RubyResolve
          include Virtus.model

          attribute :mid, String
          attribute :type, String
          attribute :sub_type, String
          attribute :content, String
        end

        attribute :id, String
        attribute :name, String
        attribute :parent_id, String
        attribute :collection_order, Integer
        attribute :description, String
        attribute :md_dc, MetaData
        attribute :md_source, Array[MetaData]
        attribute :navigate, Boolean
        attribute :publish, Boolean
        attribute :thumbnail, String
        attribute :external_id, String
        attribute :external_system, String

        def to_hash
          result = self.attributes
          result[:md_dc] = result[:md_dc].attributes if result[:md_dc]
          result[:md_source] = result[:md_source].map { |md| md.attributes }
          result
        end

      end

    end
  end
end
