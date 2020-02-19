require 'dry-types'
require 'dry-struct'

module BackupStructTypes

  include Dry::Types.module

  VALID_BACKUP_STRATEGIES = [
    :archive_directory,
    :archive_file
  ].freeze
  BackupStrategies = Strict::Symbol.constrained(included_in: VALID_BACKUP_STRATEGIES)

end

class BackupTarget < Dry::Struct::Value

  attribute :name, BackupStructTypes::Strict::String
  attribute :path, BackupStructTypes::Strict::String
  attribute :strategy, BackupStructTypes::BackupStrategies

end

module BackupTargets

  USERNAME = 'tscheffert'.freeze
  DIRS_TO_ZIP = [
  ].freeze

  ROAMING_DIR = File.join('C:', 'Users', USERNAME, 'AppData', 'Roaming')

  def self.create_from(username:)
    targets = []

    # Directories
    targets << BackupTarget.new(
                 name:     'history_zsh',
                 path:     File.join('C:', 'Users', USERNAME, '.zsh_history'),
                 strategy: :archive_directory)
    targets << BackupTarget.new(
                 name:     'history_conemu',
                 path:     File.join('C:', 'Users', 'tscheffert', 'ConEmu-Logs'),
                 strategy: :archive_directory)
    targets << BackupTarget.new(
                 name:     'config_ssh',
                 path:     File.join('C:', 'Users', 'tscheffert', '.ssh'),
                 strategy: :archive_directory)
    targets << BackupTarget.new(
                 name:     'dir_docs',
                 path:     File.join('C:', 'Projects', 'docs'),
                 strategy: :archive_directory)
    targets << BackupTarget.new(
                 name:     'dir_notes',
                 path:     File.join('C:', 'Projects', 'notes'),
                 strategy: :archive_directory)
    targets << BackupTarget.new(
                 name:     'dir_powershell_scripts',
                 path:     File.join('C:', 'Projects', 'powershell-scripts'),
                 strategy: :archive_directory)
    targets << BackupTarget.new(
                 name:     'dir_registry_changes',
                 path:     File.join('C:', 'Projects', 'registry-changes'),
                 strategy: :archive_directory)
    targets << BackupTarget.new(
                 name:     'dir_scripts',
                 path:     File.join('C:', 'Projects', 'scripts'),
                 strategy: :archive_directory)
    targets << BackupTarget.new(
                 name:     'dir_gimp_config',
                 path:     File.join(ROAMING_DIR, 'GIMP', '2.10'),
                 strategy: :archive_directory)
    targets << BackupTarget.new(
                 name:     'dir_typora_config',
                 path:     File.join(ROAMING_DIR, 'Typora', 'conf'),
                 strategy: :archive_directory)
    targets << BackupTarget.new(
                 name:     'dir_wox_config',
                 path:     File.join(ROAMING_DIR, 'Wox', 'Settings'),
                 strategy: :archive_directory)

    # Repos
    targets << BackupTarget.new(
                 name:     'repo_devtools',
                 path:     File.join('C:', 'Projects', 'gitlab', 'devops', 'devtools'),
                 strategy: :archive_directory)

    # Files
    targets << BackupTarget.new(
                 name:     'history_bash',
                 path:     File.join('C:', 'Users', USERNAME, '.bash_history'),
                 strategy: :archive_file)
    targets << BackupTarget.new(
                 name:     'history_powershell',
                 path:     File.join(ROAMING_DIR, 'Microsoft', 'Windows', 'PowerShell', 'PSReadline', 'ConsoleHost_history.txt'),
                 strategy: :archive_file)
    targets << BackupTarget.new(
                 name:     'history_pry',
                 path:     File.join('C:', 'Users', 'tscheffert', '.pry_history'),
                 strategy: :archive_file)
    targets << BackupTarget.new(
                 name:     'history_irb',
                 path:     File.join('C:', 'Users', 'tscheffert', '.irb_history'),
                 strategy: :archive_file)
    targets << BackupTarget.new(
                 name:     'history_less',
                 path:     File.join('C:', 'Users', 'tscheffert', '.lesshst'),
                 strategy: :archive_file)

    targets
  end

end
