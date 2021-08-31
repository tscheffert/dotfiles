require 'spec_helper'

# TODO: This isn't done yet, totally WIP. But it passes, and I got other stuff to do, so commit!

# TODO: Maybe symlink `example_optimist_script` to `example_optimist_script.rb`, or vice versa. So we can use `require` instead of `load`
load dotfiles_root.join('bin', 'example_optimist_script')

describe ExampleOptimistScript, :hide_stdout do
  describe '::perform' do
    let(:args) { ['--video', 'thing.mp4'] }

    it 'functions like we expect' do
      expect{ ExampleOptimistScript.perform(args: args) }.to_not raise_error
    end

    xit 'requires video arg'

    xit 'has flag --no-cleanup'

    xit 'responds to --help'

    xit 'has a nice banner'

  end

  describe 'ARGV stuff' do
    it 'is an array' do
      expect(ARGV).to be_an(Array)
    end
  end
end
