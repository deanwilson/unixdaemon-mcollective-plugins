class MCollective::Application::Augeas<MCollective::Application
  description "Client to the AugeasQuery Plugin Execution system"
  usage "Usage: augeas <query>"

  def post_option_parser(configuration)
    configuration[:query] = ARGV.shift if ARGV.size > 0
  end

  def validate_configuration(configuration)
    raise "Please specify a query" unless configuration.include?(:query)
  end

  def main
    augeas = rpcclient("augeasquery")

    augeas_results = augeas.query(:query => configuration[:query])

    puts

    augeas_results.each do |result|
      printf("%-40s\n", result[:sender])
      result[:data][:matched].each do |matched|
        printf("    %-40s\n", matched)
      end
    end

    puts

  end
end
