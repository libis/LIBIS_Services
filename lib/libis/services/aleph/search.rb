# coding: utf-8

require 'libis/tools/extend/hash'
require 'libis/tools/xml_document'

require 'libis/services/generic_search'

module Libis
  module Services
    module Aleph

      class Search
        include ::Libis::Services::GenericSearch

        attr_accessor :host

        def find(term, options = {})
          super

          response = execute_http_query("op=find&code=#{options[:index]}&request=#{options[:term]}&base=#{options[:dbase]}")
          if response
            set_number = response['//find/set_number'].to_s
            num_records = response['//find/no_records'].to_i
            session_id = response['//find/session-id'].to_s
            return options.merge id: set_number, num_records: num_records, session_id: session_id, record_pointer: 1
          end
          {}

        end

        def each(options)

          return unless ([:record_pointer, :num_records] & options.keys).size == 2

          while options[:record_pointer] <= options[:num_records]
            next_record(options) { |r| yield r }
          end

          options
        end

        def next_record(options = {}, &block)

          return nil unless ([:record_pointer, :num_records, :set_number, :dbase] & options.keys).size == 4

          if options[:record_pointer] <= options[:num_records]
            response = execute_http_query(
                'op=present' +
                    "&set_entry=#{options[:record_pointer]}" +
                    "&set_number=#{options[:set_number]}" +
                    "&base=#{options[:dbase]}"
            )

            if response
              response.add_node 'search', type: 'opac', host: host, base: options[:dbase]
              set_entry = response['//set_entry'].to_i
              if set_entry == options[:record_pointer]
                add_item_data(response, options[:dbase])
                block_given? ? yield response : return response
              end
            end
          else
            puts 'no record found'
          end

        ensure
          options[:record_pointer] += 1

        end

        private

        def add_item_data(xml_document, options)

          doc_number = xml_document['//doc_number']
          response = execute_http_query("op=item-data&base=#{options[:dbase]}&doc-number=#{doc_number}")

          if response

            oai_marc = xml_document.get_node(:oai_marc)

            #noinspection RubyResolve
            response.get_nodes(:item).each do |r|
              collection = response.value(:collection, r)
              location = response.value(:sub-library, r)
              classification = response.value('call-no-1', r)

              varfield = xml_document.add_node 'varfield', nil, oai_marc, id: '852', i1: ' ', i2: ' '

              xml_document.add_node 'subfield', collection, varfield, label: 'b'
              xml_document.add_node 'subfield', location, varfield, label: 'c'
              xml_document.add_node 'subfield', classification.gsub('$$h', ''), varfield, label: 'h'

            end
          end
        end


        def execute_http_query(data)
          raise Exception, 'No host set' if host.nil? || host.size == 0

          redo_count = 10
          xml_document = nil

          redo_search = false

          begin
            redo_search = false

            begin
              redo_count = redo_count - 1
              sleep_time = 0.1 # in minutes

              response = Net::HTTP.fetch(host, :data => data, :action => :post)

              if response.is_a?(Net::HTTPOK)
                xml_document = Libis::Tools::XmlDocument.parse(response.body)
                error = xml_document['//error']

                unless xml_document && error.nil?
                  unless error == 'empty set'
                    puts
                    puts "----------> Error searching for #{data} --> '#{error}'"
                    puts
                  end
                  if error =~ /license/
                    redo_search = true
                  end
                end
              else
                puts response.error!
              end
            rescue Exception => ex
              sleep_time = 0.5
              if ex.message =~ /503 "Service Temporarily Unavailable"/
                sleep_time = 30
                Libis::Tools::Config.logger.warn "OPAC Service temporarily unavailable - retrying after #{sleep_time} minutes"
              else
                Libis::Tools::Config.logger.error "Problem with OPAC: '#{ex.message}' - retrying after #{sleep_time} minutes"
                ex.backtrace.each { |x| Libis::Tools::Config.error "#{x}" }
              end
              redo_search = true
            end

            sleep sleep_time * 60 if redo_search

          end until redo_search == false or redo_count < 0

          xml_document

        end

      end

    end
  end
end
