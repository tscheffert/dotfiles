module ConsoleConfig

  module SetupReadline

    def self.do
      require 'readline'
      if Readline::VERSION =~ %r{editline}i
        warn 'Warning: Using Editline instead of Readline.'
      end

      # tell Readline when the window resizes
      return unless Readline.respond_to? :set_screen_size
      old_winch = trap 'WINCH' do
        if `stty size` =~ %r{\A(\d+) (\d+)\n\z}
          Readline.set_screen_size Regexp.last_match(1).to_i, Regexp.last_match(2).to_i
        end
        old_winch.call unless old_winch.nil?
      end
    end

  end

  module ReplaceActiveRecordLoggers

    def self.do
      if defined?(ActiveRecord)
        ActiveRecord::Base.logger = Logger.new(STDOUT)
        ActiveRecord::Base.clear_active_connections!
      end
    end
  end

end
