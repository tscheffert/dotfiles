require 'json'
require 'paint'

module JSONHelper

  # From Devtools JSONHelper
  def self.validate!(json_file:, argument_name:)
    if json_file.blank?
      warn Paint["Validating #{argument_name}: Provided JSON file argument was blank!", :Red]
      exit 1
    end

    unless File.exist?(json_file)
      warn Paint["Validating #{argument_name}: No such file: '#{json_file}'", :red]
      exit 1
    end

    unless File.extname(json_file) == '.json'
      warn Paint["Validating #{argument_name}: File '#{json_file}' is not a JSON file", :red]
      exit 1
    end

    if File.empty?(json_file)
      warn Paint["Validating #{argument_name}: File '#{json_file}' is empty", :red]
      exit 1
    end
  end

  # From Devtools JSONHelper
  def self.safe_parse!(json_file:)
    JSON.parse(File.read(json_file))
  rescue JSON::ParserError => e
    if e.message == "783: unexpected token at ''"
      warn Paint["JSON file '#{json_file}' is empty", :red]
      exit 1
    else
      warn Paint["JSON Parser Error: #{e}", :red]
      exit 1
    end
  rescue StandardError => e
    warn Paint["Unknown error while parsing JSON from file '#{json_file}'\n  Error: #{e}\n  Backtrace: #{e.backtrace.join("\n")}", :red]
    exit 1
  end

end
