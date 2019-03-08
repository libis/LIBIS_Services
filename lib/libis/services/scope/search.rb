require 'libis/services/generic_search'
require 'libis/services/oracle_client'
require 'libis/tools/xml_document'

module Libis
  module Services
    module Scope

      class Search
        include ::Libis::Services::GenericSearch

        attr_reader :oracle

        def initialize
          @doc = nil
        end

        def connect(name, password, database = nil)
          database ||= 'libis-db-scope.cc.kuleuven.be:1556/SCOPEP.kuleuven.be'
          @oracle = OracleClient.new("#{name}/#{password}@#{database}")
          self
        end

        def connect_url(url)
          @oracle = OracleClient.new(url)
          self
        end

        def find(term, options = {})
          super
        end

        def query(term, options = {})

          case options[:type] || 'REPCODE'
            when 'REPCODE'
              @oracle.call('kul_packages.scope_xml_meta_file_ed', [term.upcase])
            when 'ID'
              @oracle.call('kul_packages.scope_xml_meta_file_by_id', [term.to_i])
            else
              raise RuntimeError, "Invalid Scope search type '#{options[:type]}'"
          end
          term = term.gsub(/[-\/]/, '_')
          err_file = "/nas/vol03/oracle/#{options[:dir] || 'SCOPEP'}/#{term}_err.XML"
          md_file = "/nas/vol03/oracle/#{options[:dir] || 'SCOPEP'}/#{term}_md.XML"
          if File.exist? err_file
            doc = Libis::Tools::XmlDocument.open(err_file)
            msg = doc['/error/error_msg']
            detail = doc['/error/error_']
            File.delete(err_file) rescue nil
            @doc = nil
            raise RuntimeError, "Scope search failed: '#{msg}'. Details: '#{detail}'"
          elsif File.exist? md_file
            @doc = Libis::Tools::XmlDocument.open(md_file)
            File.delete(md_file) rescue nil
            @doc
          else
            raise RuntimeError, 'Scope search did not generate expected result file.'
          end
        end

        def each(_ = {})
          yield @doc
        end

        def next_record(_ = {})
          yield @doc
        end

      end

    end
  end
end
