metadata :name => "SimpleRPC File MD5 generator",
            :description => "Agent that generates an MD5 checksum of the given file path",
            :author => "Dean Wilson",
            :license => "GPLv2",
            :version => "0.1",
            :url => "http://www.unixdaemon.net/mcollective-plugins/",
            :timeout => 20

action "checksum", :description => "Checksum the file" do
    display :always

    input :filename,
          :prompt      => "Filename",
          :description => "The file to checksum",
          :type        => :string,
	  :validation  => '.',
          :optional    => false

    output :checksum,
          :description => "The files checksum",
          :display_as  => "File checksum"

end
