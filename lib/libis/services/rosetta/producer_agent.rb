require 'virtus'

module Libis
  module Services
    module Rosetta
      class ProducerAgent
        # noinspection RubyResolve
        include Virtus.model(nullify_blank: true)

        attribute :first_name, String
        attribute :last_name, String
        attribute :user_name, String
        attribute :job_title, String
        attribute :street, String
        attribute :suburb, String
        attribute :city, String
        attribute :country, String
        attribute :address_5, String
        attribute :zip, String
        attribute :email_address, String
        attribute :web_site_url, String
        attribute :telephone_1, String
        attribute :telephone_2, String
        attribute :user_group, String

        def to_hash
          attributes.cleanup
        end

        def to_xml
          Libis::Tools::XmlDocument.build do |xml|
            # noinspection RubyResolve
            xml.user_info {
              xml.parent.default_namespace = 'http://www.exlibrisgroup.com/xsd/dps/backoffice/service'
              self.attributes.each do |name, value|
                xml.send(name, xmlns: '').text(value) if value
              end
            }
          end.to_xml(save_with: Nokogiri::XML::Node::SaveOptions::DEFAULT_XML | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)
        end

        def self.from_xml(xml)
          xml_doc = Libis::Tools::XmlDocument.parse(xml)
          hash = xml_doc.to_hash(
              strip_namespaces: true,
              delete_namespace_attributes: true,
              empty_tag_value: nil,
              convert_tags_to: lambda(&:to_sym)
          )
          # noinspection RubyArgCount
          self.new(hash[:producer_info])
        end
      end
    end
  end
end
