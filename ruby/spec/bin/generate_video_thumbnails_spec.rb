require 'spec_helper'

# Example Specs:
# https://dev.azure.com/echo-it/devcenter/_git/devtools?path=%2Fspec%2Funit%2Fdevtools%2Fapi_client_spec.rb

# TODO: Maybe symlink `example_optimist_script` to `example_optimist_script.rb`, or vice versa. So we can use `require` instead of `load`
load dotfiles_root.join('bin', 'generate_video_thumbnails')

describe GenerateVideoThumbnails do
  describe '::perform' do
    let(:args) { ['--video', 'example.mp4'] }

    context 'with good args' do
      it 'runs without error' do
        expect{ GenerateVideoThumbnails.perform(args: args) }.to_not raise_error
      end

      xit 'has flag --no-cleanup'

      xit 'responds to --help'

      xit 'has a nice banner'

    end

    context 'with bad args' do
      xit 'requires video arg' do

      end

    end

  end
end
