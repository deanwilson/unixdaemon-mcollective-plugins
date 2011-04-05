metadata :name => "File Locator",
            :description => "Agent that 'locates' all instances of a filename",
            :author      => "Dean Wilson",
            :license     => "GPLv2",
            :version     => "0.1",
            :url         => "http://www.unixdaemon.net/mcollective-plugins/",
            :timeout     => 20

action "locator", :description => "Locate filename" do
    display :always

    input :filename,
          :prompt      => "Filename",
          :description => "The file to locate",
          :type        => :string,
          :validation  => '.',
          :optional    => false

    output :occurances,
           :description => "Paths matching filename",
           :display_as  => "Paths matching filename"
end


action "count_located", :description => "Count of filenames located" do
    display :always

    input :filename,
          :prompt      => "Filename",
          :description => "The file to locate",
          :type        => :string,
          :validation  => '.',
          :optional    => false

    output :count,
           :description => "Number of paths matching filename",
           :display_as  => "Located"

end
