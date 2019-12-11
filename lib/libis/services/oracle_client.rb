# frozen_string_literal: true
if RUBY_PLATFORM == 'java'
  require 'java'
  require 'ojdbc8.jar'
  require 'orai18n.jar'
  java_import 'oracle.jdbc.pool.OracleDataSource'
else
  require 'oci8'
end

module Libis
  module Services

    class OracleClient

      attr_reader :url, :oci

      def initialize(url)
        @url = url
        @oci = if RUBY_PLATFORM == 'java'
          raise RuntimeError, 'Malformed database URL' unless url =~ /^(.*)\/(.*)@(.*)$/
          user, pass, db = $1, $2, $3
          uri = "jdbc:oracle:thin:@#{db}"
          ods = OracleDataSource.new
          ods.set_url(uri)
          ods.set_user(user)
          ods.set_password(pass)
          ods.get_connection
        else
          OCI8.new(url)
        end
        ObjectSpace.define_finalizer(self, self.class.finalize(@oci))
      end

      def self.finalize(oci)
        if RUBY_PLATFORM == 'java'
          proc { oci.close }
        else
          proc { oci.logoff }
        end
      end

      # @param [Boolean] value
      def blocking=(value)
        oci.non_blocking = !value
        blocking?
      end

      def blocking?
        !oci.non_blocking?
      end

      def call(procedure, parameters = [])
        params = ''
        params = "'" + parameters.map(&:to_s).join("','") + "'" if parameters and parameters.size > 0
        oci.exec("call #{procedure}(#{params})")
      end

      def execute(statement, *bindvars, &block)
        oci.exec(statement, *bindvars, &block)
      end

      def table(name)
        metadata = oci.describe_table(name)
        {
            columns: metadata.columns.map do |column|
              {
                  name: column.name,
                  type: column.data_type,
                  size: case column.data_type
                          when :number
                            column.precision
                          when :varchar2
                            column.char_size
                          else
                            column.data_size
                        end,
                  required: !column.nullable?
              }
            end
        }
      end

      def run(script, parameters = [])
        params = ''
        params = "\"" + parameters.join("\" \"") + "\"" if parameters&.size.to_i > 0
        process_result `sqlplus -S #{url} @#{script} #{params}`
      end

      private

      def process_result(log)
        log.gsub!(/\n\n/, "\n")
        rows_created = 0
        log.match(/^(\d+) rows? created.$/) { |m| rows_created += m[1] }
        rows_deleted = 0
        log.match(/^(\d+) rows? deleted.$/) { |m| rows_deleted += m[1] }
        rows_updated = 0
        log.match(/^(\d+) rows? updated.$/) { |m| rows_updated += m[1] }
        errors = Hash.new(0)
        error_count = 0
        log.match(/\nERROR .*\n([^\n]*)\n/) { |m| errors[m[1]] += 1; error_count += 1 }
        {created: rows_created, updated: rows_updated, deleted: rows_deleted, errors: error_count, error_detail: errors}
      end

    end

  end
end
