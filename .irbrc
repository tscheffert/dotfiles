# Better IRB, started from: https://github.com/dstrelau/dotfiles/blob/master/irbrc

# IRB.conf[:USE_READLINE] = true
IRB.conf[:PROMPT_MODE] = :SIMPLE if IRB.conf[:PROMPT_MODE] == :DEFAULT
IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000

require 'irb/completion'
require 'irb/ext/save-history'
require 'logger'

if defined?(ActiveRecord)
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  ActiveRecord::Base.clear_active_connections!
end

class Object
  def interesting_methods
    (self.methods - Object.instance_methods).sort
  end

  def pbcopy(stuff)
    IO.popen('pbcopy', 'r+') {|c| c.puts stuff }
    stuff
  end

  def pbpaste
    `pbpaste`.chomp
  end
end

def as
  require 'active_support/all'
end

def exceptions
  ObjectSpace.each_object(Class).each_with_object([]) do |cls,ex|
    ex << cls if cls.ancestors.include? Exception
  end.uniq
end
