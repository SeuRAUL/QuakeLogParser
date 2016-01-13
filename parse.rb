logfile = ARGV.first

data = File.open(logfile)

games = []

def init_game
  @game = {total_kills: 0,
          players: [],
          kills: {},
          kills_by_means: {}}
end

def info_miner(line)
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

  return player1.join(' '), player2.join(' '), line[line.length-1]
end

data.each do
  kill = data.readline.split(' ')

  if kill.include? "Kill:"
    @game[:total_kills] += 1

    # get the name os players
    player1, player2, mean_of_kill = info_miner(kill)


    if player1 != "<world>"

      # Address player1 to tha list of players
      @game[:players] << player1   unless @game[:players].include?(player1)
      
      # Count kills
      !@game[:kills].has_key?(player1) ? @game[:kills][player1] = 1 : @game[:kills][player1] += 1

    else  # decrease kill of player killed by <world>
      !@game[:kills].has_key?(player2) ? @game[:kills][player2] = -1 : @game[:kills][player2] -= 1
    end
    
    # Address player2 to tha list of players
    @game[:players] << player2 unless @game[:players].include?(player2)

    @game[:kills_by_means].has_key?(mean_of_kill) ? @game[:kills_by_means][mean_of_kill] += 1 : @game[:kills_by_means][mean_of_kill] = 1


  elsif kill.include? "ShutdownGame:"
    games << @game

    init_game
  end
end


## print games
number = 1
games.each do |game|
  if game.is_a?(Hash)
    puts "game_#{number}: {\n"
    puts "\ttotal_kills: #{game[:total_kills]};\n"
    puts "\tplayers: #{game[:players]}\n"
    puts "\tkills: {\n"
    game[:kills].each do |k, v|
      puts "\t\t\"#{k}\": #{v}"
    end
    puts "\t}\n"
    puts "\tkills_by_means: {\n"
    game[:kills_by_means].sort.reverse.each do |k, v|
      puts "\t\t\"#{k}\": #{v}"
    end
    puts "\t}\n"
    puts "}\n"
    puts
    number += 1
  end
end


data.close