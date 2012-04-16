class MCollective::Application::Augeas<MCollective::Application
  description "Client to the AugeasQuery Plugin Execution system"
  usage "Usage: augeas [OPTIONS] <ACTION> <PATH>"

  option :transform,
      :description    => "Associate lens to path",
      :arguments      => ["--transform LENS=PATH[,LENS=PATH]*"]

  def post_option_parser(configuration)
    if ARGV.length >= 2
      configuration[:command] = ARGV.shift
      configuration[:path] = ARGV.shift

      unless configuration[:command].match(/^(match|count)$/)
        raise "Action must be match or count"
      end
    else
      STDERR.puts("No action and path specified")
      exit!
    end
  end

  def validate_configuration(configuration)
    raise "Please specify a path" unless configuration.include?(:path)
  end

  def main

    case configuration[:command]
    when "match"
      augeas = rpcclient("augeasquery")

      augeas_results = augeas.query(:query => configuration[:path], :transform => configuration[:transform])

      puts

      augeas_results.each do |result|
        printf("%-40s\n", result[:sender])
        result[:data][:matched].each do |matched|
          printf("    %-40s\n", matched)
        end
      end

      puts

    when "count"
      augeas = rpcclient("augeasquery")

      augeas_results = augeas.query(:query => configuration[:path], :transform => configuration[:transform])

      puts

      augeas_results.each do |result|
         printf("%-40s\n", result[:sender])
         printf("    %d matches found\n", result[:data][:matched].length)
      end

      puts

    end

  end
end
