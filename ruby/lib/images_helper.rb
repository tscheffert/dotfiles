require 'active_support/core_ext/object/blank'
require 'dimensions'

require 'bigdecimal'
require 'fileutils'

module ImagesHelper
  module Constants

    IMAGE_EXTENSIONS = ['.png', '.PNG', '.jpg', '.JPG', '.jpeg', '.JPEG'].freeze

    ALREADY_FLAT_DIRS_DIR = '_already_flat_dirs'.freeze
    BAD_DIR = '_bad'.freeze
    GOOD_DIR = '_good'.freeze
    LANDSCAPE_DIR = '_landscape'.freeze
    NOT_SQUARE_DIR = '_not_square'.freeze
    PORTRAIT_DIR = '_portrait'.freeze
    SORTED_DIR = '_sorted'.freeze
    TOO_SMALL_DIR = '_too_small'.freeze

    IGNORED_DIRS = [
      ALREADY_FLAT_DIRS_DIR,
      BAD_DIR,
      GOOD_DIR,
      LANDSCAPE_DIR,
      NOT_SQUARE_DIR,
      PORTRAIT_DIR,
      SORTED_DIR,
      TOO_SMALL_DIR,
      '.',
      '..'
    ].freeze

    MIN_WIDTH = 2495
    MIN_HEIGHT = 1440
    MIN_RATIO = BigDecimal('1.77')
    MAX_RATIO = BigDecimal('1.78')

  end

  def self.all_images_in_dir(dir)
    Dir.entries(dir).select do |f|
      File.file?(f) && Constants::IMAGE_EXTENSIONS.include?(File.extname(f))
    end
  end

  def self.all_dirs_in(dir:)
    Dir.entries(dir).select { |entry| File.directory?(entry) } - Constants::IGNORED_DIRS
  end

  def self.safe_rename(old, new)
    FileUtils.mv(old, new)
  rescue => e
    warn "File #{old} -> #{new} failed with error #{e}"
  end

  def self.safe_remove_dir(dir)
    if Dir.empty?(dir)
      FileUtils.rmdir(dir)
    else
      warn "Dir #{dir} not empty, not removing"
    end
  rescue => e
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
