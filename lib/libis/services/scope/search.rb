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

        def connect(name, password)
          @oracle = OracleClient.new(
              'libis-db-scope.cc.kuleuven.be:1556/SCOPEP.kuleuven.be',
              name, password
          )
        end

        def find(term, options = {})
          super
        end

        def query(term, _options = {})
          @oracle.call('kul_packages.scope_xml_meta_file_ed', [term.upcase])
          term = term.gsub(/[-\/]/, '_')
          err_file = "/nas/vol03/oracle/SCOPEP/#{term}_err.XML"
          md_file = "/nas/vol03/oracle/SCOPEP/#{term}_md.XML"
          if File.exist? err_file
            doc = Libis::Tools::XmlDocument.open(err_file)
            msg = doc['/error/error_msg']
            detail = doc['/error/error_']
            File.delete(err_file) rescue nil
            @doc = nil
            raise RuntimeError, "Scope search failed: '#{msg}'. Details: '#{detail}'"
          elsif File.exist? md_file
            @doc = Libis::Tools::XmlDocument.open(md_file)
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
