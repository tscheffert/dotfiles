# Ruby Snippets

## General

### Finding an Executable

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

## Script Utilities

### Option Parsing with Optimist

```ruby
options = Optimist.options(args) do
  banner <<~BANNERDOC
    Converts jpeg images to default ICC sRGB in a given folder
      Usage:
        #{File.basename(__FILE__)} [options]
      where [options] are:
  BANNERDOC

  opt :test, 'Run in test mode, reporting which images will be converted without doing it', short: :none
  opt :directory, 'Which directory to convert images in', short: :none, default: Dir.pwd
end

if !Dir.exist?(options[:directory])
  Optimist.die(:directory, "'#{options[:directory]}' does not exist")
end

@test_run = options[:test]

ensure_tools_exist!

```

### Command Running

```ruby
result = TTY::Command.new(printer: :null)
  .run!("magick identify -format \"%[profile:icc]\" \"#{image}\"")

if result.stdout.strip == 'Adobe RGB (1998)'
  return true
elsif result.stdout.strip.include?('sRGB')
  return false
elsif result.stdout.present?
  warn "Unexpected color profile found, '#{result.stdout.strip}'. test if converting to icc sRGB works"
  exit 1
elsif !result.success?
  warn 'Unexpected failure checking for color profile'
  warn "STDERR: #{result.stderr}" if result.stderr.present?
  exit 1
else
  return false
end
```

## Directories

Get the list of all the contents of a directory. Without the `'.'`, `'..'`, and "unix-style hidden files" (aka dot prefixed). In `UTF-8`.

```
contents = Dir.glob('*', base: File.absolute_path(path_to_dir))
# => Returns paths without the base prefixed
```

Alternative:
```
contents = Pathname.new(path_to_dir).glob('*')
# => Returns full paths to the contents, as Pathname objects
```

If you're going to use `Dir.entries`, make sure to specify the `encoding: 'UTF-8'` option


## Literal Dictionaries

Load a dictionary, filter by word length, then use it to generate

```ruby
MINIMUM_WORD_LENGTH = 4
MAXIMUM_WORD_LENGTH = 6

def self.dictionary
  @_dictionary ||= begin
    words = File.readlines("/usr/share/dict/words", chomp: true).map { |w| w.strip.downcase }.uniq
    puts "Loaded #{words.length} words from /usr/share/dict/words"

    reduced_words = words.select do |word|
      word.length >= MINIMUM_WORD_LENGTH &&
        word.length <= MAXIMUM_WORD_LENGTH
    end
    puts "Reduced to #{reduced_words.length} are between min and max"

    reduced_words.group_by { |word| word[0] }
  end
end
private_class_method :dictionary

# Use whatever mnemonic you want to generate for a passphrase
mnemonic = 'word'
phrase = []
mnemonic.each_char do |character|
  possible_words = dictionary[character].length
  index = SecureRandom.random_number(possible_words)
  word = dictionary[character][index]

  phrase << word
end
passphrase = phrase.join('-') + '1'
```
