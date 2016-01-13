logfile = ARGV.first

data = File.open(logfile)

games = []

game = {total_kills: 0,
        players: [],
        kills: {}}

def players(line)
  player1 = []
  player2 = []
  i = 5   # 1st indice of player1
  
  while(line[i] != 'killed')
    player1 << line[i]
    i += 1
  end
  
  i += 1     # pass  killed   and begin player2
  
  while(line[i] != 'by')
    player2 << line[i]
    i += 1
  end

  return player1.join(' '), player2.join(' ')
end

# data.each do
(1..200).each do
  kill = data.readline.split(' ')

  if kill.include? "Kill:"
    game[:total_kills] += 1

    # get the name os players
    player1, player2 = players(kill)

    if player1 != "<world>"

      # Address players
      game[:players] << player1   unless game[:players].include?(player1)
      
      # Count kills
      !game[:kills].has_key?(player1) ? game[:kills][player1] = 1 : game[:kills][player1] += 1

    else  # decrease kill of player killed by <world>
      !game[:kills].has_key?(player2) ? game[:kills][player2] = -1 : game[:kills][player2] -= 1
    end
    
    game[:players] << player2 unless game[:players].include? player2

    

    puts "#{player1} #{player2} #{kill[kill.length-1]}"

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