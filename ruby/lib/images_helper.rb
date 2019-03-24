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

    IGNORED_DIRS = [
      BAD_DIR,
      NOT_SQUARE_DIR,
      TOO_SMALL_DIR,
      LANDSCAPE_DIR,
      PORTRAIT_DIR,
      '.',
      '..'
    ].freeze

    MIN_WIDTH = 2560
    MIN_HEIGHT = 1440
    MIN_RATIO = BigDecimal('1.77')
    MAX_RATIO = BigDecimal('1.78')

  end
end
