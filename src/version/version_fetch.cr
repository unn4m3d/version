require "yaml"

file = ARGV.first? || __FILE__

path = File.expand_path file

found = false

until found
  path = File.dirname path
  if File.exists? File.join(path, "shard.yml")
    data = YAML.parse File.read(File.join(path, "shard.yml"))
    puts %("#{data["version"].as_s}")
    found = true
  end
  break if path == File.dirname path
end

puts %("<unknown>") unless found
