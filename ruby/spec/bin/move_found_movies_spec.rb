require 'spec_helper'

load dotfiles_root.join('bin', 'move_found_movies')

describe MoveFoundMovies, :hide_stdout, :hide_stderr do
  describe '::perform' do
    let(:args) { ['--output', 'thing.mp4'] }

    it 'functions like we expect' do
      expect { MoveFoundMovies.perform(args: args) }.to_not raise_error
    end

    context "when we don't pass --output" do

      it "it dies and explains why" do
        # Have to do a composable matcher here cause output matching without the `raise_error` doesn't catch the expections
        expect { MoveFoundMovies.perform(args: []) }
          .to raise_error(SystemExit)
          .and output(/--output must be specified/).to_stderr
      end

    end

    it 'responds to --help' do
      expect { MoveFoundMovies.perform(args: ['--help']) }.to output(/Move movies to a new folder/).to_stdout

    end

  end
end
