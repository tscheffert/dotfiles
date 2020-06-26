
# Ruby Snippets

Example of finding an executable in a folder

```ruby
def self.magick_in_program_files
  # Is it in program files?
  imagemagick_install_folders = Pathname.new(PROGRAM_FILES).children.select do |child_path|
    child_path.directory? && child_path.to_s.include?('ImageMagick')
  end

  if imagemagick_install_folders.length > 1
    puts "Found more than one imagemagick install, using the first one found"
  end

  install_folder = imagemagick_install_folders.first

  magick_exe = install_folder.join('magick.exe')
  if !File.exist?(install_folder.join('magick.exe'))
    warn "Found imagemagick installed at #{install_folder} but could not find magick.exe'"
    exit 1
  end

  magick_exe.to_s.gsub('\\', '/')
end
```
