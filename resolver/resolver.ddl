metadata :name => "DNS Resolver",
            :description => "Agent that resolves a given host and record type",
            :author      => "Dean Wilson",
            :license     => "GPLv2",
            :version     => "0.1",
            :url         => "http://www.unixdaemon.net/mcollective-plugins/",
            :timeout     => 20

action "resolve", :description => "Resolve host (and record type)" do
    display :always

    input :host,
          :prompt      => "Host",
          :description => "The host to resolve",
          :type        => :string,
          :validation  => '.',
          :optional    => false,
          :maxlength   => 80

    input :type,
          :prompt      => "Record type",
          :description => "The record type to resolve.",
          :type        => :string,
          :validation  => '.', # TODO
          :optional    => true,
          :maxlength   => 80

    output :records,
           :description => "Query Results",
           :display_as  => "Query Results"

end
