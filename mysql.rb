module MCollective
  module Agent
    class Mysql<RPC::Agent
      require 'rubygems'

      metadata :name => "MySQL Agent",
               :description => "Simple MySQL Agent for state retrieval",
               :author => "Dean Wilson",
               :license => "GPLv2",
               :version => "0.1",
               :url => "http://www.unixdaemon.net/mcollective-plugins/",
               :timeout => 20

      # check we have the required db lib.
      begin
        require 'mysql'
      rescue Exception => e
        reply.fail! e.to_s
      end

      # Actions
      #############################################

      action 'get_setting' do
        query = "SHOW GLOBAL STATUS LIKE '#{request[:query]}';"

        reply[:matched] = get_result( query )
      end

      action 'get_variable' do
        query = "SHOW GLOBAL VARIABLES LIKE '#{request[:query]}';"

        reply[:matched] = get_result( query )
      end

      #############################################
      private
      #############################################

      def get_result( query )
        dbh = get_connection( find_auth( @dbname ) )

        r = dbh.query( query )
        dbh.close if dbh

        if r.num_rows == 0
          reply.fail! "MySQL doesn't know about [#{request[:query]}]"
        end

        r.fetch_hash["Value"] || {}
      end


      def get_connection( auth )
        dbhost = '127.0.0.1'
        dbname = 'mysql'

        begin
          dbh = ::Mysql.new( dbhost, auth[:username], auth[:password], dbname )
        rescue ::Mysql::Error => e
          reply.fail! "Failed to connect: #{e.to_s}"
        end

        dbh
      end


      def find_auth( dbname )
        authfile = config.pluginconf["mysql.authfile"]

        # sanity checks
        reply.fail! "Please set plugin.mysql.authfile in your config file" if authfile.nil?
        reply.fail! "Unable to read #{authfile}" unless File.readable?( authfile )

        auths = {}

        # lines in the auth file look like "dbname::username::password"
        IO.read( authfile ).split.each do | db |
          database, username, password = db.split("::")

          auths[database] = { :username => username, :password => password, :database => database }
        end

        auth = {}
        if auths.keys.include?( dbname )
          auth = auths[dbname]
        else
          auth = auths["__default__"]
        end

        auth
      end

    end
  end
end
