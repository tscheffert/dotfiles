# Better IRB, started from: https://github.com/dstrelau/dotfiles/blob/master/irbrc
# Also good: https://github.com/jasoncodes/dotfiles/blob/master/config/irbrc
# Load hooks from: https://github.com/itspriddle/dotfiles/blob/master/irb.d/on_load.rb

require 'irb/ext/save-history'
require 'logger'
require '~/console_config.rb'

module IRB
  def self.hooks
    @hooks ||= []
  end

  def self.on_load
    hooks << Proc.new
  end

  def self.run_onload!
    hooks.shift.call while hooks.any?
  end

  IRB.conf[:IRB_RC] = Proc.new do
    IRB.run_onload!
  end
end

ConsoleConfig::SetupReadline.perform

IRB.on_load do
  ConsoleConfig::ReplaceActiveRecordLoggers.perform
end

IRB.conf[:USE_READLINE] = true
IRB.conf[:EVAL_HISTORY] = 1000
IRB.conf[:SAVE_HISTORY] = 1000

ANSI = {
  RESET:     "\e[0m",
  BOLD:      "\e[1m",
  UNDERLINE: "\e[4m",
  LGRAY:     "\e[0;37m",
  GRAY:      "\e[1;30m",
  RED:       "\e[31m",
  GREEN:     "\e[32m",
  YELLOW:    "\e[33m",
  BLUE:      "\e[34m",
  MAGENTA:   "\e[35m",
  CYAN:      "\e[36m",
  WHITE:     "\e[37m"
}.freeze
ANSI.each do |_, v|
  v.replace("\001#{v}\002")
end

def colorize(str, color, trailing = '')
  "#{ANSI[color]}#{str}#{ANSI[:RESET]}#{trailing}"
end

# Build a simple colourful IRB prompt
IRB.conf[:PROMPT][:SIMPLE_COLOR] =
  {
    PROMPT_I:    colorize('>>', :BLUE,   ' '),
    PROMPT_N:    colorize('>>', :GREEN,  ' '),
    PROMPT_C:    colorize('?>', :RED,    ' '),
    PROMPT_S:    colorize('?>', :YELLOW, ' '),
    RETURN:      colorize('=>', :GREEN,  "%s\n"),
    AUTO_INDENT: true
  }
IRB.conf[:PROMPT_MODE] = :SIMPLE_COLOR

ConsoleConfig::Debundler.debundle!

ConsoleConfig::Helpers.extend_console('wirb') { Wirb.start } unless defined? Wirb
ConsoleConfig::Helpers.extend_console('bond') { Bond.start } unless defined? Bond

class Object

  def interesting_methods
    case self.class
    when Class
      (public_methods - Object.public_methods).sort
    when Module
      (public_methods - Module.public_methods).sort
    else
      (public_methods - Object.new.instance_methods).sort
    end
  end

  def pbcopy(stuff)
    IO.popen('pbcopy', 'r+') { |c| c.puts stuff }
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
  ObjectSpace.each_object(Class).each_with_object([]) { |cls, ex|
    ex << cls if cls.ancestors.include? Exception
  }.uniq
end

# Ensure colors are reset at exit
Kernel.at_exit { puts (ANSI[:RESET]).to_s }
