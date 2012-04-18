metadata :name => "Augeas Based Config Query",
         :description => "Augeas Based Config Querying",
         :author => "Dean Wilson",
         :license => "GPLv2",
         :version => "0.1",
         :url => "http://www.unixdaemon.net/mcollective-plugins/",
         :timeout => 20

action 'query', :description => "Query the given augeas path" do
    display :always

    input :query,
          :prompt      => "Pattern to match",
          :description => "Only display configs matching this query",
          :type        => :string,
          :validation  => '^/.+$',
          :optional    => false,
          :maxlength    => 300

    output :matched,
           :description => "Path Matches",
           :display_as  => "Path Matches"

end
