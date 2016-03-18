# Better IRB, started from: https://github.com/dstrelau/dotfiles/blob/master/irbrc

require 'irb/completion'
require 'irb/ext/save-history'
require 'logger'

# IRB.conf[:USE_READLINE] = true
IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000

ANSI = {
  RESET: "\e[0m",
  BOLD: "\e[1m",
  UNDERLINE: "\e[4m",
  LGRAY: "\e[0;37m",
  GRAY: "\e[1;30m",
  RED: "\e[31m",
  GREEN: "\e[32m",
  YELLOW: "\e[33m",
  BLUE: "\e[34m",
  MAGENTA: "\e[35m",
  CYAN: "\e[36m",
  WHITE: "\e[37m"
}
ANSI.each do |_, v|
  v.replace("\001#{v}\002")
end

# Build a simple colourful IRB prompt
IRB.conf[:PROMPT][:SIMPLE_COLOR] =
  {
    PROMPT_I:    "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
    PROMPT_N:    "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
    PROMPT_C:    "#{ANSI[:RED]}?>#{ANSI[:RESET]} ",
    PROMPT_S:    "#{ANSI[:YELLOW]}?>#{ANSI[:RESET]} ",
    RETURN:      "#{ANSI[:GREEN]}=>#{ANSI[:RESET]} %s\n",
    AUTO_INDENT: true
  }
IRB.conf[:PROMPT_MODE] = :SIMPLE_COLOR

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

# Ensure colors are reset at exit
Kernel.at_exit { puts "#{ANSI[:RESET]}" }
