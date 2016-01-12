logfile = ARGV.first

data = File.open(logfile)

# data.each do
(1..100).each do
  kill = data.readline.split(' ')

  puts "#{kill[5]} #{kill[7]} #{kill[9]}" if kill.include? "Kill:"
end


data.close