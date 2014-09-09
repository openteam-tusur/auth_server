config_file = Rails.root.join('config/settings.yml')

if File.exist? config_file
  Settings.read(config_file)
else
  raise "Please, create a #{config_file}!"
end
