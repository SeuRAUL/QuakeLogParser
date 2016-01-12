logfile = ARGV.first

data = File.open(logfile)

games = []

game = {total_kills: 0,
        players: [],
        kills: {}}

# data.each do
(1..200).each do
  kill = data.readline.split(' ')

  if kill.include? "Kill:"
    game[:total_kills] += 1

    if kill[5] != "<world>"

      # Address players
      game[:players] << kill[5]   unless game[:players].include?(kill[5])
      
      # Count kills
      !game[:kills].has_key?(kill[5]) ? game[:kills][kill[5]] = 1 : game[:kills][kill[5]] += 1

    end
    
    
    game[:players] << kill[7] unless game[:players].include? kill[7]

    

    puts "#{kill[5]} #{kill[7]} #{kill[9]}"

  elsif kill.include? "ShutdownGame:"
    puts "\n\ngame:", game

    games << game

    game = {total_kills: 0,
            players: [],
            kills: {}}
  end
end

#puts "\n\ngame: total_kills= #{game[:total_kills]}\n #{game[:players]}"
puts "\n\ngames:", games


data.close