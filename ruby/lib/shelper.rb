require 'mixlib/shellout'
require 'active_support'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/array/wrap'

require File.join(__dir__, 'path_helper')
require File.join(__dir__, 'platform')

# Based on Chef::Mixin::ShellOut, with significant modification:
#   https://github.com/chef/chef/blob/7d8660c67f2a48bc5623a258bdfa58b0a5ad6180/lib/chef/mixin/shell_out.rb
module Shelper

  DEFAULT_LOCALE = 'en_US.UTF-8'.freeze
  DEBUG = true

  def self.out(command:, options:)
    validate_out_args(command: command, args: args, options: options)

    if command.kind_of?(Array)
      shell_out(command: clean_array(command), options: options)
    else
      shell_out(command: command, options: options)
    end
  end

  def self.out!(command:, options:)
    validate_out_args(command: command, options: options)

    if command.kind_of?(Array)
      shell_out(command: clean_array(command), options: options)
    else
      shell_out(command: command, options: options)
    end
  end

  private

  def self.validate_out_args(command:, options:)
    raise 'Invalid command' if !(command.kind_of?(String) || command.kind_of?(Array))
    raise 'Invalid options' if !options.kind_of?(Hash)
  end
  private_class_method :validate_out_args

  # @return [Array] array of strings with nil and null string rejection
  def self.clean_array(*args)
    args.flatten.compact.map(&:to_s)
  end
  private_class_method :clean_array

  def self.shell_out(command:, options:)
    options = options.dup
    env_key = options.has_key?(:env) ? :env : :environment
    options[env_key] = {
      'LC_ALL' => DEFAULT_LOCALE,
      'LANGUAGE' => DEFAULT_LOCALE,
      'LANG' => DEFAULT_LOCALE,
      env_path => PathHelper.sanitized_path,
    }.update(options[env_key] || {})
    shell_out_command(command: command, options: options)
  end
  private_class_method :shell_out

  def self.shell_out!(command:, options:)
    # TODO: This should throw up if stderr has output and stdout doesn't
    cmd = shell_out(command: command, options: options)
    cmd.error!
    cmd
  end
  private_class_method :shell_out!

  def self.shell_out_command(command:, options:)
    cmd =
      if Platform.windows?
        windows_mixlib_shell_out(command: command, options: options)
      else
        Mixlib::ShellOut.new(*command, **options)
      end
    cmd.live_stream ||= io_for_live_stream
    cmd.run_command
    cmd
  end
  private_class_method :shell_out_command

  def self.windows_mixlib_shell_out(command:, options:)
    # Mixlib::ShellOut doesn't support command fragments on windows
    # https://github.com/chef/mixlib-shellout/issues/125

    # This doesn't work because it fucks up shell splitting
    # require 'shellwords'
    # command = Shellwords.join(command) if command.kind_of?(Array)

    Mixlib::ShellOut.new(join_command_fragments(command: command), **options)
  end

  def self.join_command_fragments(command:)
    return command if command.kind_of?(String)

    joined = command.reduce('') do |cmd, frag|
      cmd <<
        if frag.include?(' ')
          " \"#{frag}\""
        else
          " #{frag}"
        end
    end

    joined.strip
  end

  def self.io_for_live_stream
    if STDOUT.tty? && DEBUG
      STDOUT
    else
      nil
    end
  end
  private_class_method :io_for_live_stream

  def self.env_path
    if Platform.windows?
      "Path"
    else
      "PATH"
    end
  end
  private_class_method :env_path
end
