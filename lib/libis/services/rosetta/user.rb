require 'virtus'

module Libis
  module Services
    module Rosetta
      class User
        # noinspection RubyResolve
        include Virtus.model nullify_blank: true

        RECORD_TYPE = %w'USER CONTACT ORGANIZATION STAFF PUBLIC'
        USER_STATUS = %w'ACTIVE INACTIVE DELETED'
        USER_ROLES_STATUS = %w'NEW ACTIVE INACTIVE PENDING DELETED'
        USER_TYPE = %w'CASUAL INTERNAL EXTERNAL INTEXTAUTH'

        attribute :first_name, String
        attribute :last_name, String
        attribute :user_name, String
        attribute :user_group, String
        attribute :expiry_date, String
        attribute :job_title, String
        attribute :default_language, String
        attribute :street, String
        attribute :suburb, String
        attribute :city, String
        attribute :country, String
        attribute :address_1, String
        attribute :address_2, String
        attribute :address_3, String
        attribute :address_4, String
        attribute :address_5, String
        attribute :zip, Integer
        attribute :email_address, String
        attribute :web_site_url, String
        attribute :telephone_1, String
        attribute :telephone_2, String
        attribute :fax, String

        attribute :password, String
        attribute :password_verify, String

        def to_hash
          super.cleanup
        end

        def to_xml
          Libis::Tools::XmlDocument.build do |xml|
            # noinspection RubyResolve
            xml.user_info {
              xml.parent.default_namespace = 'http://www.exlibrisgroup.com/xsd/dps/backoffice/service'
              self.attributes.each do |name, value|
                xml.send(name, xmlns: '') { xml.text(value) } if value
              end
            }
          end.to_xml
        end

        def self.from_xml(xml)
          xml_doc = Libis::Tools::XmlDocument.parse(xml)
          hash = xml_doc.to_hash(
              strip_namespaces: true,
              delete_namespace_attributes: true,
              empty_tag_value: nil,
              convert_tags_to: lambda { |tag| tag.to_sym }
          )
          self.new(hash[:producer_info])
        end
      end
    end
  end
end