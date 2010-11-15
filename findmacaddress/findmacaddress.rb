module MCollective
  module Agent
    class Findmacaddress<RPC::Agent

      metadata :name => "SimpleRPC MAC Addess Finder",
               :description => "Agent that finds which machines have seen a MAC address",
               :author => "Dean Wilson",
               :license => "GPLv2",
               :version => "0.1",
               :url => "http://www.unixdaemon.net/mcollective-plugins/",
               :timeout => 20


      action "findmacaddress" do
        validate :macaddress, String

        reply[:sightings] = []
        macaddress = request[:macaddress].upcase

        arpcmd = '/sbin/arp -n'
        %x{#{arpcmd}}.each do |line| # TODO make the arp bin location a config option.
          fields = line.split(/\s+/)

          if fields[2].upcase == macaddress
            reply[:sightings] << { :ip => fields[0], :interface => fields[4] }
          end
        end

      end
    end
  end
end
