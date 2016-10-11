# Customize Pry! more info: https://github.com/pry/pry/wiki/Customization-and-configuration
# Also good: https://github.com/jasoncodes/dotfiles/blob/master/config/pryrc

require '~/console_config.rb'
ConsoleConfig::SetupReadline.perform
ConsoleConfig::ReplaceActiveRecordLoggers.perform

# TODO: Debundler.debundle! working for pry so we can awesome_print here too

# Set the prompt_name to the foldername
Pry.config.prompt_name = File.basename(Dir.pwd)

Pry::Commands.block_command 'pretty_methods', 'Arg.public_methods minus Object.public_methods, sorted' do |obj_string, cols|
  obj = target.eval(obj_string)

  list = nil
  list = if obj.class == Class
           (obj.instance_methods - obj.superclass.instance_methods).sort
         else
           (obj.public_methods - obj.superclass.public_methods).sort
  end

  cols = default_columns_for_size(list.length, cols)

  # print_row_sorted(list)
  print_column_sorted(list, cols)
end

def default_columns_for_size(size, cols)
  default_cols = nil
  if size < 15
    default_cols = 1
  elsif size < 30
    default_cols = 3
  elsif size < 100
    default_cols = 5
  end
  cols = cols.to_i
  cols = default_cols if cols == 0

  cols
end

def print_row_sorted(string_array, columns)
  largest = string_array.max.length
  string_array.each_slice(columns) { |row| output.puts row.map { |e| "%#{largest}s" % e }.join('  ') }
end

def print_column_sorted(string_array, columns)
  largest = string_array.max.length

  rows = ((string_array.size + 2) / columns)
  cols = string_array.each_slice(rows).to_a
  cols.first.zip(*cols[1..-1]).each { |row| output.puts row.map { |e| e ? "%#{largest}s" % e : ' ' * largest }.join('  ') }
end
