require("colorize")
require("tty-prompt")
require_relative("./startup.rb")
require_relative("./monster.rb")

def prompt
    prompt = TTY::Prompt.new
end

player_monster_selector = ""
def choose_monster
    player_monster_selector = TTY::Prompt.new
    return player_monster_selector.select(
        "Choose your monster to battle with, good luck...",
        [
            "Bulbasaur".colorize(:color => :black, :background => :green),
            "Charmander".colorize(:color => :black, :background => :light_red),
            "Squirtle".colorize(:color => :black, :background => :cyan)
        ]
    )
end

opponent_monster = ""
def battle_setup
    moves_1 = {"Tackle" => 10, "Grass Whip" => 15}
    moves_2 = {"Scratch" => 10, "Flamethrower" => 15}
    moves_3 = {"Headbutt" => 10, "Watergun" => 15}
    monster1 = Monster.new("Bulbasaur".colorize(:color => :black, :background => :green), 100, moves_1)
    monster2 = Monster.new("Charmander".colorize(:color => :black, :background => :light_red), 100, moves_2)
    monster3 = Monster.new("Squirtle".colorize(:color => :black, :background => :cyan), 100, moves_3)
    playerMonsterArray = [monster1, monster2, monster3]
    monster1 = Monster.new("Bulbasaur".colorize(:color => :black, :background => :green), 100, moves_1)
    monster2 = Monster.new("Charmander".colorize(:color => :black, :background => :light_red), 100, moves_2)
    monster3 = Monster.new("Squirtle".colorize(:color => :black, :background => :cyan), 100, moves_3)
    opponentMonsterArray = [monster1, monster2, monster3]

    sleep(0.5)
    puts "Welcome to MY battle simulation, #{ARGV[0]}."
    sleep(1.5)
    puts "I am the champion of this application."
    sleep(1.5)
    puts "You won't be able to defeat me!!!"
    sleep(1.5)
    puts ""
    player_choice = choose_monster
    case player_choice
    when "Bulbasaur".colorize(:color => :black, :background => :green)
        player_choice = playerMonsterArray[0]
        puts "You have selected #{player_choice.name}"
    when "Charmander".colorize(:color => :black, :background => :light_red)
        player_choice = playerMonsterArray[1]
        puts "You have selected #{player_choice.name}"
    else
        player_choice = playerMonsterArray[2]
        puts "You have selected #{player_choice.name}"
    end
    sleep(1)
    puts ""
    opponent_monster = opponentMonsterArray.sample
    if ARGV[1].capitalize == "Hard"
        opponent_monster.max_health = (opponent_monster.max_health * 1.5).round
        opponent_monster.health = (opponent_monster.health * 1.5).round
    end
    puts "Your opponent has selected #{opponent_monster.name}"
    puts""
    sleep(1.5)
    puts"BATTLE START!"
    sleep(0.5)
    loading_bar
    system "clear"
    return [player_choice, opponent_monster]
end

def battle(player_choice, opponent_monster)
    loop do
        # Do the players turn
        puts "Your Turn!"
        sleep(0.75)
        player_choice.show_health_bar
        puts ""
        opponent_monster.show_health_bar
        sleep(1)
        puts ""
        move = player_choice.ask_moves
        system "clear"

        player_choice.use_move(move, opponent_monster)
        system "clear"

        # Check if player wins
        if opponent_monster.health <= 0
            puts "You Win! :D"
            sleep(1)
            system "clear"
            break
        end

        puts "Enemy's Turn!"
        sleep(1)
        move = opponent_monster.moves.keys.sample
        opponent_monster.use_move(move, player_choice)
        system "clear"

        # Check is opponent wins
        if player_choice.health <= 0
            puts "You Lose! :("
            sleep(1)
            system "clear"
            break
        end
    end
end
