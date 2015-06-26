# encoding: utf-8
require 'virtus'

require 'libis/tools/extend/hash'
require_relative 'client'

module Libis
  module Services
    module Rosetta

      class UserManager < Libis::Services::Rosetta::Client

        RECORD_TYPE = %w'USER CONTACT ORGANIZATION STAFF PUBLIC'
        USER_STATUS = %w'ACTIVE INACTIVE DELETED'
        USER_ROLES_STATUS = %w'NEW ACTIVE INACTIVE PENDING DELETED'
        USER_TYPE = %w'CASUAL INTERNAL EXTERNAL INTEXTAUTH'

        class UserInfo
          # noinspection RubyResolve
          include Virtus.model

          attribute :record_type, String
          attribute :user_record_type, String
          attribute :user_type, String
          attribute :expiry_date, String
          attribute :status, String

          attribute :user_name, String
          attribute :first_name, String
          attribute :last_name, String
          attribute :user_group, String

          attribute :email_address, String
          attribute :default_language, String
          attribute :jobTitle, String
          attribute :webSiteUrl, String
          attribute :telephone1, String
          attribute :telephone2, String
          attribute :fax, String
          attribute :address1, String
          attribute :address2, String
          attribute :address3, String
          attribute :address4, String
          attribute :address5, String
          attribute :zip, String

          attribute :externalId, String
          attribute :secretKey, String
          attribute :password, String
          attribute :passwordVerify, String
          attribute :passExpDate, String
          attribute :passExpDateDummy, String

          attribute :userRoles, String
        end

        def initialize(base_url = 'http://depot.lias.be', options = {})
          super 'infra', 'UserManagerWS', {url: base_url}.merge(options)
        end

        ## Update user
        def user(user_id, user_info)
          user_info = user_info.attributes if user_info.is_a? UserInfo
          do_request :update_user, arg0: user_info, arg1: user_id
        end

        protected

      end

    end
  end
end