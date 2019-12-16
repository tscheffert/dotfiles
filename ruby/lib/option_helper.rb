require 'dry-types'
require 'dry-struct'
require 'optparse'

class Bool; end

module OptionStructTypes

  include Dry::Types.module

  # TODO: Further investigate coercion options
  VALID_OPTION_TYPES = [
    ::String,
    ::Array,
    ::Bool
  ].freeze

  CommandLineParseableTypes = Strict::Class.constrained(included_in: VALID_OPTION_TYPES)

end

class Option < Dry::Struct::Value

  attribute :command_line_name, OptionStructTypes::Strict::String
  attribute :variable_key, OptionStructTypes::Strict::Symbol
  attribute :description, OptionStructTypes::Strict::String
  attribute :option_type, OptionStructTypes::CommandLineParseableTypes
  attribute :required, OptionStructTypes::Strict::Bool

  def usage_display
    if option_type == Bool
      "[#{command_line_name}]"
    elsif required
      "#{command_line_name} <#{variable_key.to_s.upcase}>"
    else
      "[#{command_line_name} <#{variable_key.to_s.upcase}>]"
    end
  end

end

class OptionHelper

  attr_reader :options, :script_name

  def initialize(script_name:)
    @options = []
    @script_name = script_name
  end

  def add_option(command_line_name:, variable_key:, description:, option_type:, required:)
    if option_type == Bool && required
      raise "Bool options cannot be required, they must be optional"
    end

    option_struct =
      Option.new(
        command_line_name: command_line_name,
        variable_key:      variable_key,
        description:       description,
        option_type:       option_type,
        required:          required)

    @options << option_struct
  end

  def parse!(argv:)
    results = {}
    required_args = {}
    flag_args = []

    parser = OptionParser.new do |opts|
      opts.banner = render_banner

      @options.each do |option|
        if option.option_type == Bool
          opts.on(
            :OPTIONAL,
            option.command_line_name.to_s,
            option.description) do |_|
              results[option.variable_key] = true
            end

          flag_args << option.variable_key
        elsif option.required
          opts.on(
            :REQUIRED,
            "#{option.command_line_name} #{option.variable_key.to_s.upcase}",
            option.option_type,
            option.description) do |parsed_var|
              results[option.variable_key] = parsed_var
            end

          required_args[option.variable_key] = option.command_line_name
        else
          opts.on(
            "#{option.command_line_name} [#{option.variable_key.to_s.upcase}]",
            option.option_type,
            option.description) do |parsed_var|
              results[option.variable_key] = parsed_var
            end
        end
      end
    end

    parser.parse!(argv)

    # Validate that all required_args are present
    if required_args.present?
      missing_args = required_args.select { |k, _v| results[k].blank? }
      if missing_args.present?
        raise OptionParser::MissingArgument.new(missing_args.values.join(', '))
      end
    end

    # Coerce flag args to false from nil if they havent' been provided
    if flag_args.present?
      missing_flag_args = flag_args.select { |flag| results[flag].blank? }
      missing_flag_args.each do |flag|
        results[flag] = false
      end
    end

    # TODO: OptionParser doesn't support "additional validation", so do that here
    # Example: raise "Cannot find file for shared-patterns: #{options[:shared_patterns_file]}" unless File.exist?(options[:shared_patterns_file])

    # parser.parse! is destructive, if any arguments are left they're invalid
    raise "Invalid arguments: #{argv}" if argv.present?

    results
  rescue OptionParser::InvalidOption, OptionParser::MissingArgument => e
    warn e.to_s
    warn parser
    exit 1
  end

  private

  def render_banner
    banner = ''

    banner << 'Usage:'
    banner << ' '
    banner << @script_name
    banner << ' '

    # TODO: Should these options be sorted somehow?
    #   Right now they're in the order they're added which seems reasonable
    banner << @options.map(&:usage_display).join(' ')

    banner
  end

end
