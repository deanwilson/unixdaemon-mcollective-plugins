module MCollective
  module Agent
    class Locator<RPC::Agent

      metadata :name => "File Locator",
               :description => "Agent that 'locates' all instances of a filename",
               :author      => "Dean Wilson",
               :license     => "GPLv2",
               :version     => "0.1",
               :url         => "http://www.unixdaemon.net/mcollective-plugins/",
               :timeout     => 20


      action "locator" do
        validate :filename, String

        matching = `locate --regex #{request[:filename]}`.to_a.map(&:chomp)

        reply[:occurances] = matching

      end

      action "count_located" do
        validate :filename, String

        count = `locate --regex #{request[:filename]}`.to_a.map(&:chomp).length

        reply[:count] = count
      end
    end
  end
end
