# Based on ChefConfig's windows.rb, with no modification:
#   https://github.com/chef/chef/blob/686113531d23f30e9973d659c456ae33eb9cff1f/chef-config/lib/chef-config/windows.rb
module Platform
  def self.windows?
    if RUBY_PLATFORM =~ /mswin|mingw|windows/
      true
    else
      false
    end
  end
end
