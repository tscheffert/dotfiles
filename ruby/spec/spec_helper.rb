require 'pathname'

# Docs:
#   https://rspec.info/documentation/3.10/rspec-core/RSpec/Core/Configuration.html
#   https://relishapp.com/rspec/rspec-core/v/3-10/docs
RSpec.configure do |config|
  # Set the default formatter (output) to dots, *, and F's
  config.default_formatter = 'progress'

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Docs:
  #   https://rspec.info/documentation/3.10/rspec-expectations/RSpec/Expectations/Configuration.html
  #   https://relishapp.com/rspec/rspec-expectations/v/3-10/docs
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true

    # Don't trucate output
    expectations.max_formatted_output_length = nil

    # Only :except (not :should) expectations
    expectations.syntax = :expect

    # Warn about matcher use which will potentially cause false positives in tests
    expectations.warn_about_potential_false_positives = true
  end

  # Docs:
  #   https://rspec.info/documentation/3.7/rspec-mocks/RSpec/Mocks/Configuration.html
  #   https://relishapp.com/rspec/rspec-mocks/v/3-10/docs
  #   https://github.com/rspec/rspec-mocks/blob/17cf86ab61544b93232c4e9ca9784ab212dccbf6/lib/rspec/mocks/configuration.rb
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = false

    # Ensure constants that are mocked exist
    mocks.verify_doubled_constant_names = true

    # No :should mocks allowed
    mocks.syntax = :expect

    # Don't allow expectations set on nil, catch bugs early and prevent false positives
    mocks.allow_message_expectations_on_nil = false

    # Sets whether or not RSpec will yield the receiving instance of a message
    # to blocks that are used for any_instance stub implementations.
    # Should be false, cause it enables shennanigans, but defaults to true. We'll turn
    # it off and see if there are consequences.
    mocks.yield_receiver_to_any_instance_implementation_blocks = false

    # Sets the default for the transfer_nested_constants option when stubbing constants.
    # Note: No idea what this does, the documentation sucks
    mocks.transfer_nested_constants = true

    # Don't patch Marshal.dump, this feature has been soft deprecated for awhile. Just be explicit about disabling it.
    mocks.patch_marshal_to_support_partial_doubles = false
  end

  # Raise errors for deprecated rspec syntax
  config.raise_errors_for_deprecations!

  # Colored tests are more _exciting_
  config.color_mode = :on

  # Set the order to random unless we pass it in from the command line
  config.order = :rand unless ARGV.any? { |arg| %w[--order --seed].include?(arg) }

  # Initialize ruby randomness with the rspec seed
  Kernel.srand(config.seed)

  # Use the updated shared_context metadata behavior rather than soon to be deprecated default
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Sync STDOUT so that everything appears in order
  STDOUT.sync = true

  # TODO: I would like to do something like this, even if this specifically doesn't work
  # config.before(:example) do |example|
  #   if example.metadata[:hide_stdout]
  #     allow(STDOUT).to receive(:puts)
  #     allow(STDERR).to receive(:puts)
  #   end
  # end
end

def dotfiles_root
  @_dotfiles_root ||= Pathname.new(File.absolute_path(File.join(__dir__, '..', '..')))
end
