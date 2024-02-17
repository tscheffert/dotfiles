require 'fileutils'
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

  def self.safe_rename(old, new)
    FileUtils.mv(old, new)
  rescue StandardError => e
    warn "File rename '#{old}' -> '#{new}' failed with error #{e}"
  end

  # def self.safe_remove_dir(dir)
  #   if Dir.empty?(dir)
  #     FileUtils.rmdir(dir)
  #   else
  #     warn "Dir #{dir} not empty, not removing"
  #   end
  # rescue StandardError => e
  #   warn "Dir #{dir} removal failed with error #{e}"
  # end

  # def self.safe_remove_dir_with_contents(dir)
  #   FileUtils.rm_rf(dir)
  # rescue StandardError => e
  #   warn "Dir #{dir} removal failed with error #{e}"
  # end

end
