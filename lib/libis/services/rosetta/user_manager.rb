# encoding: utf-8
require 'virtus'

require 'libis/tools/extend/hash'
require_relative 'client'

module Libis
  module Services
    module Rosetta

      class UserManager < Libis::Services::Rosetta::Client

        def initialize(base_url = 'https://repository.teneo.libis.be', options = {})
          super 'infra', 'UserManagerWS', {url: base_url}.merge(options)
        end

        def user(user_id, user_info)
          user_info = user_info.to_hash if user_info.is_a? User
          do_request :update_user, arg0: user_info, arg1: user_id
        end

        protected

      end

    end
  end
end