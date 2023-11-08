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
    puts "Player #{player1.name}[X] VS Player #{player2.name}[O]"
  end

  def player_move(player)
    puts 'Choose a position to play (Number between 1 and 9)'
    move = gets
    true if board.register_move(move.to_i, player.symbol) == 1
  end

  def play_game
    starting_player = rand(1..2)
    player1_turn = starting_player == 1
    player2_turn = starting_player == 2
    puts player1_turn.to_s + ' ' + player2_turn.to_s
    until board.winner
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
    end
  end
end

g = Game.new
g.prepare_game
g.play_game
