require 'digest/md5'

module MCollective
  module Agent
    class Filemd5er<RPC::Agent

      metadata :name => "SimpleRPC File MD5 generator",
               :description => "Agent that generates an MD5 checksum of the given file path",
               :author => "Dean Wilson",
               :license => "GPLv2",
               :version => "0.1",
               :url => "http://www.unixdaemon.net/mcollective-plugins/",
               :timeout => 20

      def checksum_action
        validate :filename, String
        digest = Digest::MD5.hexdigest(File.read(request[:filename]))

        reply[:checksum] = digest
      end

    end
  end
end
