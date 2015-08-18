# Customize Pry! more info: https://github.com/pry/pry/wiki/Customization-and-configuration

# Set the prompt_name to the foldername
Pry.config.prompt_name = File.basename(Dir.pwd)
