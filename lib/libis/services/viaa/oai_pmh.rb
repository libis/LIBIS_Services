require 'libis/services/oai'
require 'base64'

module Libis
  module Services
    module Viaa
      class OaiPmh < Libis::Services::Oai

        def initialize(name, password)
          token = Base64.encode64("#{name}:#{password}").gsub("\n", '')
          base_url = 'https://archief.viaa.be/mediahaven-oai/oai'
          super(base_url, headers: {'Authorization' => "Basic #{token}"})
        end

      end
    end
  end
end