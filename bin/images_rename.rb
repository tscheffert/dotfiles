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

def rename_images_in_current_dir(name)
  files = all_images_in_dir('.')

  existing_regex = /\A#{name}-\d{2,3}\.[a-z]{3,4}\z/
  already_named, new = files.partition { |file_name| file_name.match(existing_regex) }

  puts "Already named #{already_named.length} images, renaming to avoid clashes" if already_named.length > 0
  already_named.sort.each do |img|
    no_clash_name = format("_%s-%s%s", File.basename(img, '.*'), SecureRandom.uuid, File.extname(img))
    safe_rename(img, no_clash_name)
    new << no_clash_name
  end

  puts "\nRenaming #{new.length} files\n"
  new.sort.each_with_index do |img, i|
    ext = File.extname(img)
    new_name = format("%s-%02d%s", name, i + 1, ext)

    safe_rename(img, new_name)
    puts "#{img} -> #{new_name}"
  end
end

name_prefix = ARGV.join('-')

raise 'No name provided' unless name_prefix

rename_images_in_current_dir(name_prefix)
