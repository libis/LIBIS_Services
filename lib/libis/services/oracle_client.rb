require 'oci8'

module Libis
  module Services

    class OracleClient

      attr_reader :oci

      def initialize(database, user, password)
        @database = database
        @user = user
        @password = password
        @oci = OCI8.new(user, password, database)
        ObjectSpace.define_finalizer( self, self.class.finalize(@oci) )
      end

      def self.finalize(oci)
        proc { oci.logoff }
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
        params = "'" + parameters.join("','") + "'" if parameters and parameters.size > 0
        oci.exec("call #{procedure}(#{params})")
      end

      def execute(statement, *bindvars, &block)
        oci.exec(statement, *bindvars, &block)
      end

      def run(script, parameters = [])
        params = ''
        params = "\"" + parameters.join("\" \"") + "\"" if parameters and parameters.size > 0
        process_result `sqlplus -S #{@user}/#{@password}@#{@database} @#{script} #{params}`
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
