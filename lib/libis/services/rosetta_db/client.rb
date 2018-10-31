module Libis
  module Services
    module RosettaDb

      class Client
        require 'libis/services/oracle_client'

        attr_accessor :url, :user, :password

        def initialize(url, user, password)
          @url = url
          @user = user
          @password = password
        end

        def connect
          @oracle = OracleClient.new("#{@user}/#{@password}@#{@url}")
        end

        def set_schema(schema)
          @oracle.execute("alter session set current_schema = #{schema}")
        end

      end

    end
  end
end
