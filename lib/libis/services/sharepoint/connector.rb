# coding: utf-8

require 'highline'
require 'libis/tools/logger'

require 'libis/services/soap_client'

module Libis
  module Services
    module Sharepoint

      class Search
        include ::Libis::Services::SoapClient
        include ::Libis::Tools::Logger
        include ::Libis::Services::GenericSearch

        private

        MY_QUERY_SYMBOLS = {
            nil => 'Eq',
            '==' => 'Eq',
            '!=' => 'Neq',
            '>' => 'Gt',
            '>=' => 'Geq',
            '<' => 'Lt',
            '<=' => 'Leq',
            'is null' => 'IsNull'
        }

        MAX_QUERY_RETRY = 10

        public

        def initialize(options = {})
          options[:server_url] = (options[:url] || 'https://www.groupware.kuleuven.be/sites/lias') + (options[:url_ext] || '/_vti_bin')
          options[:ssl] = true if options[:server_url] =~ /^https:/
          # options[:soap_url] = options[:server_url].gsub(/^(https?):\/\/)/,"\\1#{CGI.escape(username)}:#{CGI.escape(password)}@") + '/Lists.asmx'
          options[:wsse_auth] = [options[:username], options[:password]]
          options[:soap_url] = options[:server_url] + '/Lists.asmx'
          options[:wsdl_url] = options[:soap_url] + '?wsdl'
          configure options[:wsdl_url], options
          options
        end

        def query(term, options = {})

          options[:term] = term

          options[:limit] ||= 100
          options[:value_type] ||= 'Text'
          options[:query_operator] = MY_QUERY_SYMBOLS[options[:query_operator] || '==']

          options[:query_operator] = 'BeginsWith' if term =~ /^[^*]+\*$/
          options[:query_operator] = 'Contains' if term =~ /^\*[^*]+\*$/

          restart_query options

          options

        end

        def each(options)

          # we start with a new search
          restart_query options
          get_next_set options

          while records_to_process? options

            yield options[:result][:records][options[:current]]

            options[:current] += 1

            get_next_set(options) if require_next_set?(options)

          end

          restart_query(options)

        end

        protected

        def restart_query(options)
          options[:start_id] = 0
          options[:result] = nil
          options[:current] = 0
          options[:set_count] = 0
          options[:next_set] = nil
        end

        def records_to_process?(options)
          options[:current] < options[:set_count]
        end

        def require_next_set?(options)
          options[:current] >= options[:set_count] and options[:next_set]
        end

        def get_next_set(options)

          options[:current] = 0
          options[:set_count] = 0

          retry_count = MAX_QUERY_RETRY

          while retry_count > 0

            warn "Retrying (#{retry_count}) ..." if retry_count < MAX_QUERY_RETRY

            query = {
                'Query' => {
                    'Where' => {
                        options[:query_operator] => {
                            'FieldRef' => '',
                            'Value' => options[:term],
                            :attributes! => {
                                'FieldRef' => {
                                    'Name' => options[:index]
                                },
                                'Value' => {
                                    'Type' => options[:value_type]
                                }
                            }
                        }
                    }
                }
            }

            query_options = {
                'QueryOptions' => {
                    'ViewAttributes' => '',
                    :attributes! => {
                        'ViewAttributes' => {
                            'Scope' => 'RecursiveAll'
                        }
                    }
                }
            }

            now = Time.now
            window_start = Time.new(now.year, now.month, now.day, 12, 15)
            window_end = Time.new(now.year, now.month, now.day, 13, 15)
            if options[:selection] and now > window_start and now < window_end
              query_options['QueryOptions']['Folder'] = options[:server_url] + 'Gedeelde%20documenten/' + options[:selection] + '/.'
            end

            if options[:next_set]
              query_options['QueryOptions']['Paging'] = ''
              query_options['QueryOptions'][:attributes!]['Paging'] = {'ListItemCollectionPositionNext' => options[:next_set]}
            end

            result = request 'GetListItems', {
                                               soap_options: {
                                                   endpoint: options[:soap_url]
                                               },
                                               wsse_auth: options[:wsse_auth],
                                               listName: options[:base],
                                               viewName: '',
                                               query: query,
                                               viewFields: {'ViewFields' => ''},
                                               rowLimit: options[:limit].to_s,
                                               query_options: query_options,
                                               webID: ''
                                           }, {}, options

            if result[:error]
              warn "SOAP error: '#{result[:error]}'"
              raise RuntimeError, 'Too many SOAP errors, giving up.' unless retry_count > 0
            elsif result[:exception]
              warn "SOAP exception: '#{result[:exception].message}'"
              raise result[:exception] unless retry_count > 0
            else
              options[:result] = result
              options[:set_count] = result[:count]
              options[:next_set] = result[:next_set]
              retry_count = 0
              retry_count = MAX_QUERY_RETRY + 1 if options[:set_count] == 0 and options[:next_set]
            end

            retry_count -= 1

          end

        end

        def result_parser(result, options)

          records = []
          result = result[:get_list_items_response][:get_list_items_result]

          data = result[:listitems][:data]

          rows = data[:row]
          rows = [rows] unless rows.is_a? Array

          rows.each do |row|
            if options[:selection].nil? or row[:ows_FileRef] =~ /^\d+;#sites\/lias\/Gedeelde documenten\/#{options[:selection]}(|\/.*)$/
              records << clean_row(row, options)
            end
          end

          next_set = data[:@list_item_collection_position_next]

          # the itemcount in the response is not interesting. We count only the records that match our selection criteria.
          count = records.size

          {next_set: next_set, records: records, count: count}

        end

        def clean_row(row, options)

          options[:fields_found] ||= Set.new
          row.keys.each { |k| options[:fields_found] << k }

          fields_to_be_removed = [:ows_MetaInfo]
          fields_to_be_removed = row.keys - options[:field_selection] if options[:field_selection]

          record = SharepointRecord.new

          row.each do |k, v|
            key = k.to_s.gsub(/^@/, '').to_sym
            next if fields_to_be_removed.include? key
            record[key] = v.dot_net_clean
          end

          record

        end

      end

    end
  end
end