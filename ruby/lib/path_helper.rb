require File.join(__dir__, 'platform')

# Based on Chef::Mixin::PathSanity, with light modification:
#   https://github.com/chef/chef/blob/d24976bbd8846a60d186790f38124f312e91473d/lib/chef/mixin/path_sanity.rb
module PathHelper
  def self.sanitized_path(env = ENV)
    env_path = env["PATH"].nil? ? "" : env["PATH"].dup
    path_separator = Platform.windows? ? ";" : ":"
    # ensure the Ruby and Gem bindirs are included
    # mainly for 'full-stack' Chef installs
    new_paths = env_path.split(path_separator)
    [ ruby_bindir, gem_bindir ].compact.each do |path|
      new_paths = [ path ] + new_paths unless new_paths.include?(path)
    end
    sane_paths.each do |path|
      new_paths << path unless new_paths.include?(path)
    end
    new_paths.join(path_separator).encode("utf-8", invalid: :replace, undef: :replace)
  end

  private

  def self.sane_paths
    @sane_paths ||= begin
      if Platform.windows?
        %w{}
      else
        %w{/usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin}
      end
    end
  end
  private_class_method :sane_paths

  def self.ruby_bindir
    RbConfig::CONFIG["bindir"]
  end
  private_class_method :ruby_bindir

  def self.gem_bindir
    Gem.bindir
  end
  private_class_method :gem_bindir
end

