# Customize Pry! more info: https://github.com/pry/pry/wiki/Customization-and-configuration

# Set the prompt_name to the foldername
Pry.config.prompt_name = File.basename(Dir.pwd)

Pry::Commands.block_command "pretty_methods",
  "Arg.public_methods minus Object.public_methods, sorted" do |obj, cols|
  list = (obj.public_methods - Object.public_methods).sort

  cols = cols.to_i
  cols = 5 if cols == 0

  # print_row_sorted(list)
  print_column_sorted(list, cols)
end

def print_row_sorted(string_array, columns)
  largest = string_array.max.length
  string_array.each_slice(columns) { |row| output.puts row.map { |e| "%#{largest}s" % e}.join("  ") }
end

def print_column_sorted(string_array, columns)
  largest = string_array.max.length

  rows = ((string_array.size+2)/columns)
  cols = string_array.each_slice(rows).to_a
  cols.first.zip( *cols[1..-1] ).each {|row| output.puts row.map{|e| e ? "%#{largest}s" % e : ' ' * largest}.join("  ")}
end
