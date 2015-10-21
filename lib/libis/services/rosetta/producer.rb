require 'virtus'

module Libis
  module Services
    module Rosetta
      class Producer
        # noinspection RubyResolve
        include Virtus.model(nullify_blank: true)

        attribute :authoritative_name, String, default: 'producer'
        attribute :account_type, String, default: 'GROUP'
        attribute :status, String, default: 'ACTIVE'
        attribute :expiry_date, String
        attribute :first_name, String
        attribute :last_name, String
        attribute :institution, String, default: 'institution'
        attribute :department, String, default: 'department'
        attribute :user_name, String
        attribute :producer_group, String, default: 'Published'
        attribute :negotiator_id, String
        attribute :producerProfile_id, String
        attribute :telephone_1, String
        attribute :telephone_2, String
        attribute :fax, String
        attribute :email, String
        attribute :email_notify, String
        attribute :web_site, String
        attribute :street, String
        attribute :suburb, String
        attribute :city, String
        attribute :zip_code, String
        attribute :country, String
        attribute :notes, String
        attribute :local_field_1, String
        attribute :local_field_2, String
        attribute :contactUser_id_1, String
        attribute :contactUser_id_2, String
        attribute :contactUser_id_3, String
        attribute :contactUser_id_4, String
        attribute :contactUser_id_5, String

        def to_hash
          attributes.cleanup
        end

        def to_xml
          Libis::Tools::XmlDocument.build do |xml|
            # noinspection RubyResolve
            xml.producer_info {
              xml.parent.default_namespace = 'http://www.exlibrisgroup.com/xsd/dps/backoffice/service'
              self.attributes.each do |name, value|
                xml.send(name, xmlns: '').text(value) if value
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
