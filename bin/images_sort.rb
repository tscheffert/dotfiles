require 'dimensions'
require 'bigdecimal'
require 'fileutils'

MIN_RATIO = BigDecimal.new('1.77')
MAX_RATIO = BigDecimal.new('1.78')

IMAGE_EXTENSIONS = ['.png', '.jpg', '.jpeg']

NOT_SQUARE_DIR = 'not_square'
FileUtils.mkdir_p(NOT_SQUARE_DIR)

files = Dir.entries('.').select { |f| File.file?(f) && IMAGE_EXTENSIONS.include?(File.extname(f)) }
# files -= [File.basename(__FILE__)]


square, not_square = files.partition do |img|
  begin
    width, height = Dimensions.dimensions(img)
    ratio = BigDecimal.new(width) / BigDecimal.new(height)

    MIN_RATIO < ratio && ratio < MAX_RATIO
  rescue => e
    puts "File #{img} failed with error #{e}"

    true
  end
end

puts "Moving not_square files:"
puts not_square.to_s

FileUtils.mv(not_square, NOT_SQUARE_DIR)
