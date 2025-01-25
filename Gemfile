# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'activesupport', '~> 6.1'
gem 'dimensions'
gem 'dry-struct', '~> 1.1.0' # Stick to 1.1.x as the minor bumps are often breaking
gem 'dry-types', '~> 1.2.0' # Stick to 1.2.x as the minor bumps are often breaking
gem 'gemdiff'
gem 'mixlib-shellout', '~> 3.0.4'
gem 'optimist', '~> 3.0'
gem 'paint'
gem 'rspec', '~> 3.10.0'
gem 'rubocop', '= 0.58.0'
# Rugged wraps and requires libgit2, which is a native c library. Takes some fun to get that building.
# If it fails to install, with an error about `rugged requires CMAKE` then run:
#   brew install cmake pkg-config
# Docs: https://github.com/libgit2/rugged#install
# gem 'rugged', git: 'git://github.com/libgit2/rugged.git', submodules: true
# gem 'rugged'
gem 'tty-command'
gem 'tty-markdown-cli'
gem 'tty-which'
