metadata :name => "File Counter",
         :description => "Agent that counts files in <file>",
         :author      => "Dean Wilson",
         :license     => "GPLv2",
         :version     => "0.1",
         :url         => "http://www.unixdaemon.net/mcollective-plugins/",
         :timeout     => 20

action "filecount", :description => "Count the number of files" do
    display :always

    input :file,
          :prompt      => "File",
          :description => "Count files in <file>",
          :type        => :string,
          :validation  => '^.+$',
          :optional    => true,
          :maxlength    => 1024

    output :filecount,
           :description => "Num matching filename",
           :display_as  => "Num matching filename"

end
