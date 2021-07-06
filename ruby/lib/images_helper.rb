require 'active_support/core_ext/object/blank'
require 'dimensions'
require 'dry-types'
require 'dry-struct'
require 'optimist'
require 'tty-command'

require 'bigdecimal'
require 'fileutils'
require 'pathname'

STDOUT.sync = true

# Snippets:
# images.each(&method(:puts))

module ImagesHelper

  module ImageStructTypes

    include Dry::Types()

  end

  module Constants

    IMAGE_EXTENSIONS = ['.png', '.PNG', '.jpg', '.JPG', '.jpeg', '.JPEG'].freeze

    JPEG_IMAGE_EXTENSIONS = ['.jpg', '.JPG', '.jpeg', '.JPEG'].freeze

    # Used like this:
    # image_matcher = /\AImage (?<new_name>\d{1,3}): (?<old_name>[\(\)\ \.\_A-Za-z0-9：]*)\.(?<ext>#{IMAGE_EXTENSIONS_REGEX_OR_MATCHER})/
    IMAGE_EXTENSIONS_REGEX_OR_MATCHER = IMAGE_EXTENSIONS.map { |s| s.sub(/\A\./, '') }.join('|').freeze

    SCALED_SUFFIX_REGEX = /\A(?<original_name>[\w\_\-]+?)(?<scaled_suffix>-topaz-1)(?<ext>\.(#{IMAGE_EXTENSIONS_REGEX_OR_MATCHER}))\z/

    ALREADY_FLAT_DIRS_DIR = '_already_flat_dirs'.freeze
    BAD_DIR = '_bad'.freeze
    CROPPED_DIR = '_cropped'.freeze
    CROPPED_AND_SCALED_DIR = '_cropped-scaled'.freeze
    DISPROPORTIONATE_DIR = '_disproportionate'.freeze
    GOOD_DIR = '_good'.freeze
    LANDSCAPE_DIR = '_landscape'.freeze
    NOT_SQUARE_DIR = '_not_square'.freeze
    PORTRAIT_DIR = '_portrait'.freeze
    PROPORTIONATE_DIR = '_proportionate'.freeze
    SORTED_DIR = '_sorted'.freeze
    SOURCE_DIR = '_source'.freeze
    TOO_SMALL_DIR = '_too_small'.freeze
    UNSORTED_DIR_NAME = '_unsorted'.freeze

    IGNORED_DIRS = [
      ALREADY_FLAT_DIRS_DIR,
      BAD_DIR,
      GOOD_DIR,
      LANDSCAPE_DIR,
      NOT_SQUARE_DIR,
      PORTRAIT_DIR,
      SORTED_DIR,
      TOO_SMALL_DIR,
      UNSORTED_DIR_NAME,
      '.',
      '..'
    ].freeze

    MIN_WIDTH = 2560
    MIN_HEIGHT = 1440
    MIN_RATIO = BigDecimal('1.77')
    MAX_RATIO = BigDecimal('1.78')

  end

  def self.already_sorted_dir?(dir)
    subdirs = Dir.entries(dir, encoding: 'UTF-8')

    subdirs.any? { |subdir| subdir.end_with?(Constants::LANDSCAPE_DIR) } \
      || subdirs.any? { |subdir| subdir.end_with?(Constants::PORTRAIT_DIR) }
  end

  def self.all_images_in_dir(dir)
    # Memoized by Dir so that it doesn't re-run each time it's called
    @_images_from ||= {}
    @_images_from[dir] ||=
      Dir.entries(dir, encoding: 'UTF-8').select do |f|
        File.file?(f) && Constants::IMAGE_EXTENSIONS.include?(File.extname(f))
      end
  end

  def self.all_jpeg_images_in_dir(dir)
    # Memoized by Dir so that it doesn't re-run each time it's called
    @_images_from ||= {}
    @_images_from[dir] ||=
      Dir.entries(dir, encoding: 'UTF-8').select do |f|
        File.file?(f) && Constants::JPEG_IMAGE_EXTENSIONS.include?(File.extname(f))
      end
  end

  def self.all_scaled_images_in_dir(dir)
    image_matches = all_scaled_image_matches_in_dir(dir)

    image_matches.map(&:string)
  end

  def self.all_scaled_image_matches_in_dir(dir)
    all_images = all_images_in_dir(dir)

    all_images
      .map { |img| img.match(Constants::SCALED_SUFFIX_REGEX) }
      .compact
  end

  def self.all_scaled_image_pairs_in_dir(dir)
    all_images = all_images_in_dir(dir)
    puts "--- all images length: #{all_images.length}"

    scaled_image_matches = all_scaled_image_matches_in_dir(dir)
    puts "--- scaled image matches length: #{scaled_image_matches.length}"

    scaled_image_matches.each_with_object([]) do |match, memo|
      original = match[:original_name] + match[:ext]

      no_original_matched = original.blank?

      puts "cannot match original name from, string: #{match.string} and captures: #{match.named_captures}" if no_original_matched

      cannot_find_original = !all_images.include?(original)
      puts "cannot find original from: , string: #{match.string} and captures: #{match.named_captures}" if cannot_find_original

      next if no_original_matched || cannot_find_original

      memo << {
        original: original,
        scaled:   match.string
      }
    end
  end

  def self.all_dirs_in(dir:)
    Dir.entries(dir, encoding: 'UTF-8').select { |entry| File.directory?(entry) } - Constants::IGNORED_DIRS
  end

  def self.safe_rename(old, new)
    FileUtils.mv(old, new)
  rescue StandardError => e
    warn "File #{old} -> #{new} failed with error #{e}"
  end

  def self.safe_remove_dir(dir)
    if Dir.empty?(dir)
      FileUtils.rmdir(dir)
    else
      warn "Dir #{dir} not empty, not removing"
    end
  rescue StandardError => e
    warn "Dir #{dir} removal failed with error #{e}"
  end

  def self.safe_remove_dir_with_contents(dir)
    FileUtils.rm_rf(dir)
  rescue StandardError => e
    warn "Dir #{dir} removal failed with error #{e}"
  end

  # Escape the meta chars that Dir::glob uses
  def self.safe_path_for_glob(path)
    # Backslash only for escaping, switch it to forward slashes
    path = path.gsub(/\\/, '/')

    path = path.gsub(/\*/, '\*')
    path = path.gsub(/\?/, '\?')
    path = path.gsub(/\[/, '\[')
    path = path.gsub(/\]/, '\]')
    path = path.gsub(/\{/, '\{')
    path = path.gsub(/\}/, '\}')
  end

end
