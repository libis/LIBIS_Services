# encoding: utf-8

require 'libis/services/rest_client'

module Libis
  module Services
    module Rosetta

      class PdsHandler
        include Libis::Services::RestClient

        # @param [String] base_url
        def initialize(base_url = 'https://pds.libis.be')
          configure base_url
        end

        # @param [String] user
        # @param [String] password
        # @param [String] institute
        # @return [String] PDS handle, nil if could not login
        def login(user, password, institute)
          params = {
              func: 'login-url',
              bor_id: user,
              bor_verification: password,
              institute: institute
          }
          response = get 'pds', params
          return nil unless response.code == 200 and response.body.match /pds_handle=(\d+)[^\d]/
          $1
        end

        # @param [String] pds_handle
        # @return [Boolean] true if success
        def logout(pds_handle)
          params = {
              func: 'logout',
              pds_handle: pds_handle
          }
          response = get 'pds', params
          response.code == 200
        end

        # @param [String] pds_handle
        # @return [Hash] with user information. At least containing: 'id', 'name', 'institute' and 'group'
        def user_info(pds_handle)
          params = {
              func: 'get-attribute',
              attribute: 'BOR_INFO',
              pds_handle: pds_handle
          }
          response = get 'pds', params
          return nil unless response.code == 200
          Nori.new(convert_tags_to: lambda {|tag| tag.to_sym}).parse(response.body)
        end
      end

    end
  end
end
