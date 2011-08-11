module MCollective
  module Agent
    class Augeasquery<RPC::Agent

      metadata :name => "Augeas Based Config Query",
               :description => "Augeas Based Config Querying",
               :author => "Dean Wilson",
               :license => "GPLv2",
               :version => "0.1",
               :url => "http://www.unixdaemon.net/mcollective-plugins/",
               :timeout => 20

      action 'query' do

        begin
          require 'augeas'
        rescue Exception => e
          reply.fail e.to_s
        end

        aug = Augeas.open
        matched = []

        matches = aug.match( request[:query] )

        matches.each do | match |
          matched << aug.get( match )
        end

        reply[:matched] = matched || []
      end
    end
  end
end
