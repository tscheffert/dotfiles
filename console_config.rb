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

    # Silences STDOUT, even for subprocesses.
    #
    #   quietly { system 'bundle install' }
    #
    # This method is not thread-safe.
    def self.quietly
      silence_stream(STDOUT) do
        yield
      end
    end

    # Silences both STDOUT and STDERR, even for subprocesses.
    #
    #   quietly { system 'bundle install' }
    #
    # This method is not thread-safe.
    def self.quietly!
      silence_stream(STDOUT) do
        silence_stream(STDERR) do
          yield
        end
      end
    end

    private

    # @private
    # Silences any stream for the duration of the block.
    #
    #   silence_stream(STDOUT) do
    #     puts 'This will never be seen'
    #   end
    #
    #   puts 'But this will'
    #
    # This method is not thread-safe.
    def self.silence_stream(stream)
      old_stream = stream.dup
      stream.reopen(RbConfig::CONFIG['host_os'] =~ /mswin|mingw/ ? 'NUL:' : '/dev/null')
      stream.sync = true
      yield
    ensure
      stream.reopen(old_stream)
      old_stream.close
    end
    private_class_method :silence_stream

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

  module Debundler

    # Comes with <3 from https://github.com/janlelis/debundle.rb
    def self.debundle!
      return unless defined?(Bundler)
      return unless Gem.post_reset_hooks.reject! do |hook|
        hook.source_location.first =~ %r{/bundler/}
      end
      if defined?(Bundler::EnvironmentPreserver)
        ENV.replace(Bundler::EnvironmentPreserver.new(ENV, %w[GEM_PATH]).backup)
      end
      Gem.clear_paths

      Helpers.quietly! do
        load 'rubygems/core_ext/kernel_require.rb'
        load 'rubygems/core_ext/kernel_gem.rb'
      end
    rescue => e
      warn "Debundling failed with error: #{e}"
    end

  end

end
