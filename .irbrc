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
    case self.class
    when Class
      (self.public_methods - Object.public_methods).sort
    when Module
      (self.public_methods - Module.public_methods).sort
    else
      (self.public_methods - Object.new.instance_methods).sort
    end
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

def clear_sidekiq
  require 'sidekiq'
  ss = Sidekiq::ScheduledSet.new
  puts "Clearing #{ss.size} from ScheduledSet"
  ss.clear

  rs = Sidekiq::RetrySet.new
  puts "Clearing #{rs.size} from RetrySet"
  rs.clear

  ds = Sidekiq::DeadSet.new
  puts "Clearing #{ds.size} from DeadSet"
  ds.clear

  Sidekiq::Queue.all.each do |q|
    puts "Clearing #{q.size} from #{q.name}"
    q.clear
  end
end

def exceptions
  ObjectSpace.each_object(Class).each_with_object([]) do |cls,ex|
    ex << cls if cls.ancestors.include? Exception
  end.uniq
end
