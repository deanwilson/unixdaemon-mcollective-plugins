metadata :name => "MySQL Agent",
         :description => "Simple MySQL Agent for state retrieval",
         :author => "Dean Wilson",
         :license => "GPLv2",
         :version => "0.1",
         :url => "http://www.unixdaemon.net/mcollective-plugins/",
         :timeout => 20


action 'get_setting', :description => "Query the given MySQL setting" do
  display :always

  input :query,
        :prompt      => "Detail to show",
        :description => "Show the value for this query.",
        :type        => :string,
        :validation  => '^/.+$',
        :optional    => false,
        :maxlength    => 60


  output :value,
         :description => "Current Value",
         :display_as  => "Current Value"

end

action 'get_variable', :description => "Query the given MySQL variable" do
  display :always

  input :query,
        :prompt      => "Detail to show",
        :description => "Show the value for this query.",
        :type        => :string,
        :validation  => '^/.+$',
        :optional    => false,
        :maxlength    => 60

  output :value,
         :description => "Current Value",
         :display_as  => "Current Value"

end
