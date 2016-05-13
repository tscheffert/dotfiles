module ConsoleConfig

  module Helpers

    def self.extend_console(name, options = {})
      options = { require: true }.merge(options)
      options = options.map { |k, v| v.is_a?(Proc) ? [k, v.call] : [k, v] }.to_h

      return if options.include?(:if) && !options[:if]
      require name if options[:require]

      yield if block_given?
    rescue LoadError
      warn "-- #{colorize('Warning:', :RED)} could not load '#{name}'"
      puts '-- Is it installed?'

      exit if options[:exit]
    end

  end

  module SetupReadline

    def self.perform
      require 'readline'
      if Readline::VERSION =~ /editline/i
        warn 'Warning: Using Editline instead of Readline.'
      end

      # tell Readline when the window resizes
      return unless Readline.respond_to? :set_screen_size
      old_winch = trap 'WINCH' do
        if `stty size` =~ /\A(\d+) (\d+)\n\z/
          Readline.set_screen_size Regexp.last_match(1).to_i, Regexp.last_match(2).to_i
        end
        old_winch.call unless old_winch.nil?
      end
    end

  end

  module ReplaceActiveRecordLoggers

    def self.perform
      return unless defined? ActiveRecord

      original_logger = ActiveRecord::Base.logger

      ActiveRecord::Base.logger = Logger.new(STDOUT)
      ActiveRecord::Base.clear_active_connections!

      if defined? Pry
        Pry.hooks.add_hook :after_session, :restore_logger do |*_|
          ActiveRecord::Base.logger = original_logger
          ActiveRecord::Base.clear_active_connections!
        end
      end
    end

  end

end
