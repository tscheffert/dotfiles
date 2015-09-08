# Customize Pry! more info: https://github.com/pry/pry/wiki/Customization-and-configuration

# Set the prompt_name to the foldername
Pry.config.prompt_name = File.basename(Dir.pwd)

Pry::Commands.block_command "pretty_methods",
  "Arg.public_methods minus Object.public_methods, sorted" do |obj|
  list = (obj.public_methods - Object.public_methods).sort

  print_row_sorted(list)
end

def print_row_sorted(string_array, columns=5)
  largest = string_array.max.length
  string_array.each_slice(columns) { |row| output.puts row.map { |e| "%#{largest}s" % e}.join("  ") }
end
