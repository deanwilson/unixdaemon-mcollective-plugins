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
          reply.fail! e.to_s
        end

        aug = Augeas.open

        if request[:transform]
          request[:transform].split(/,/).each do |transform|
            lens, path =  transform.split(/=/)
            aug.set('/augeas/load/'+lens+'/incl[last()+1]', path)
          end
          aug.load()
        end

        matched = []

        matches = aug.match( request[:query] )

        matches.each do | match |
          if aug.get( match )
            matched << match+" = "+aug.get( match )
          else
            matched << match
          end
        end

        reply[:matched] = matched || []
      end
    end
  end
end
