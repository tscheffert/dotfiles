require 'active_support/core_ext/object/blank'
require 'paint'

module FileHelper

  # Super similar to JSONHelper.validate!
  def self.validate!(file_path:, argument_name:)

    if file_path.blank?
      warn Paint["Validating #{argument_name}: Provided file argument was blank!", :Red]
      exit 1
    end

    unless File.exist?(file_path)
      warn Paint["Validating #{argument_name}: No such file: '#{file_path}'", :red]
      exit 1
    end

    if File.empty?(file_path)
      warn Paint["Validating #{argument_name}: File '#{file_path}' is empty", :red]
      exit 1
    end
  end
end
