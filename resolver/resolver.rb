module MCollective
  module Agent
    class Resolver<RPC::Agent

      require 'resolv'

      metadata :name => "DNS Resolver",
               :description => "Agent that resolves a given host and record type",
               :author      => "Dean Wilson",
               :license     => "GPLv2",
               :version     => "0.1",
               :url         => "http://www.unixdaemon.net/mcollective-plugins/",
               :timeout     => 20

      action "resolve" do
        validate :host, String
        validate :type, String

        type = request[:type] || "A"

        types = { "MX" => "exchange", "A" => "address" }
        unless types.include? type
          # return failure
        end

        resolver = Resolv::DNS.new
        resource = eval "Resolv::DNS::Resource::IN::#{type}"
        records  = resolver.getresources(request[:host], resource)

        if records.size > 0
          records.map! { | record | record.send( types[type] ).to_s }
          reply[:records] = records
        else
          reply[:records] = [ "None found" ]
        end
      end
    end
  end
end
