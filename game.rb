# frozen_string_literal: true

require './player'
require './board'
class Game
  attr_accessor :player1, :player2, :board

  def initialize
    @player1 = nil
    @player2 = nil
    @board = nil
  end

  # Gets the names of the players
  # Creates Player and Board objects and assigns them to the instance variables
  def prepare_game
    name1 = ''
    name2 = ''
    while name1 == ''
      puts 'Please input name of player 1[X] (cannot be empty): '
      name1 = gets.chomp
    end
    while name2 == '' || name2 == name1
      puts 'Please input name of player 2[O] (cannot be empty and same as Player 1): '
      name2 = gets.chomp
    end
    self.player1 = Player.new(name1, 'X')
    self.player2 = Player.new(name2, 'O')
    self.board = Board.new
    puts
    puts "Player #{player1.name}[X] VS Player #{player2.name}[O]"
  end

  # Registers the players move and if valid returns true else returns false
  def player_move(player)
    puts
    puts "-- #{player.name}'s [#{player.symbol}] turn --"
    puts 'Choose a position to play (Number between 1 and 9)'
    move = gets
    return true if board.register_move(move.to_i, player.symbol) == 1

    false
  end

  # Randomizes the starting player
  # Keeps track of whose turn it is and the number of turns played
  # Loops until there is a winner or the number of turns equals 8
  # The loop updates and display the board, and depending on whose turn it is lets players input their move
  # After the loop announces if the game was a draw or announces winning player
  # The winning player is chosen by having their turn equal to false given that if a player plays a winning move their turn would be false
  # Asks whether the player want to play a new game and recursively calls the method
  def play_game
    starting_player = rand(1..2)
    player1_turn = starting_player == 1
    player2_turn = starting_player == 2
    number_of_turns = 0
    until board.winner || number_of_turns == 8
      board.update_board(board.board)
      puts
      puts board.board_representation
      if player1_turn == true
        a = false
        a = player_move(player1) while a == false
        player1_turn = false
        player2_turn = true
      elsif player2_turn == true
        a = false
        a = player_move(player2) while a == false
        player2_turn = false
        player1_turn = true
      end
      board.winner = board.has_winner?
      number_of_turns += 1
    end
    board.update_board(board.board)
    puts
    puts board.board_representation
    if number_of_turns == 8
      puts "It's a draw"
      puts
    elsif player2_turn == false
      puts "The winner is Player 2 - '#{player2.name}' [#{player2.symbol}]"
      puts
    elsif player1_turn == false
      puts "The winner is Player 1 - '#{player1.name}' [#{player1.symbol}]"
      puts
    end
    puts 'Play again? (y/n)'
    decision = gets
    return unless decision.casecmp('y') == 1

    prepare_game
    play_game
  end
end

g = Game.new
g.prepare_game
g.play_game
