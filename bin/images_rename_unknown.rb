require 'fileutils'
require 'securerandom'

IMAGE_EXTENSIONS = ['.png', '.jpg', '.jpeg']

def safe_rename(old, new)
  FileUtils.mv(old, new)
rescue => e
  puts "File #{old} -> #{new} failed with error #{e}"
end

def all_images_in_dir(dir)
  Dir.entries(dir).select { |f| File.file?(f) && IMAGE_EXTENSIONS.include?(File.extname(f)) }
end

def rename_images_in_current_dir
  files = all_images_in_dir('.')

  puts "\nRenaming #{files.length} files\n"
  files.sort.each do |img|
    ext = File.extname(img)
    uuid = SecureRandom.uuid
    uuid[0..1] = 'zz'

    new_name = uuid + ext
    puts "#{img} -> #{new_name}"

    safe_rename(img, new_name)
  end
end

rename_images_in_current_dir
