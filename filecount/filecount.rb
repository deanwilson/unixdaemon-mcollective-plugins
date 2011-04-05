module MCollective
  module Agent
    class Filecount<RPC::Agent

      metadata :name => "File Counter",
               :description => "Agent that counts files in <file>",
               :author      => "Dean Wilson",
               :license     => "GPLv2",
               :version     => "0.1",
               :url         => "http://www.unixdaemon.net/mcollective-plugins/",
               :timeout     => 20

      # Basic filecount action
      action "filecount" do
        validate :file, String

        file = request[:file]

        # to make the common usecase easier 
        # TODO - show difference between not exist and no match?
        if File.directory? file
          file = "#{file}/*"
        end

        count = Dir[ file ].length
        reply[:filecount] = count
      end
    end
  end
end
