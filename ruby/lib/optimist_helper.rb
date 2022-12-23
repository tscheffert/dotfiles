require 'optimist'

module OptimistHelper

  class OptionParser

    attr_reader :options

    def initialize(script_name:)
      @options = []
      @script_name = script_name
    end

    def add_option(option_name:, description:, option_type:, required:)
      @options << {
        command_line_name: command_line_name,
        variable_key: variable_key,
        description: description,
        option_type: option_type,
        required: required
      }

      opt(option_name:)
    end

  end

  def self.parse(args:,&block)
    options = Optimist::options(args) do
      banner <<~BANNERDOC
      Optimizes JPEG files, either lossless or lossy, in a given folder

      Usage:
        #{File.basename(__FILE__)} [options]

      where [options] are:
      BANNERDOC

      opt :test, 'Run in test mode, reporting which images will be converted without doing it', short: :none
      opt :lossless, 'Optimizes JPEG files with jpegtran for lossless optimization', short: :none
      opt :lossy, 'Optimizes JPEG files with cjpeg for lossy optimization', short: :none
      opt :directory, 'Which directory to parse', short: :none, default: Dir.pwd
    end
    block.call

    options
  end

end
