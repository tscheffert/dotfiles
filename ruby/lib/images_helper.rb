require 'active_support/core_ext/object/blank'
require 'dimensions'

require 'bigdecimal'
require 'fileutils'

module ImagesHelper
  module Constants

    IMAGE_EXTENSIONS = ['.png', '.PNG', '.jpg', '.JPG', '.jpeg', '.JPEG'].freeze

    BAD_DIR = '_bad'.freeze
    NOT_SQUARE_DIR = '_not_square'.freeze
    TOO_SMALL_DIR = '_too_small'.freeze
    LANDSCAPE_DIR = '_landscape'.freeze
    PORTRAIT_DIR = '_portrait'.freeze
    FLAT_DIRS_DIR = '_flat_dirs'.freeze

    IGNORED_DIRS = [
      BAD_DIR,
      NOT_SQUARE_DIR,
      TOO_SMALL_DIR,
      LANDSCAPE_DIR,
      PORTRAIT_DIR,
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

  def self.safe_rename(old, new)
    FileUtils.mv(old, new)
  rescue => e
    puts "File #{old} -> #{new} failed with error #{e}"
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
