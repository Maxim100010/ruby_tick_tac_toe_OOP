# frozen_string_literal: true

class Board
  attr_accessor :board, :board_representation, :winner, :played_moves

  attr_reader :win_combinations

  # Takes no arguments
  # Creates the board and its visual representation
  # Creates array of winning combinations
  # Creates boolean keeping track of whether there is a winner or not
  # Creates array of moves that were already played
  def initialize
    @board = [%w[1 2 3], %w[4 5 6], %w[7 8 9]]
    @board_representation = " #{board[0][0]} | #{board[0][1]} | #{board[0][2]} " + "\n" \
                            '---+---+---' + "\n" \
                            " #{board[1][0]} | #{board[1][1]} | #{board[1][2]} " + "\n" \
                            '---+---+---' + "\n" \
                            " #{board[2][0]} | #{board[2][1]} | #{board[2][2]} "
    @win_combinations = [
      [0, 1, 2], # top_row
      [3, 4, 5], # middle_row
      [6, 7, 8], # bottom_row
      [0, 3, 6], # left_column
      [1, 4, 7], # center_column
      [2, 5, 8], # right_column
      [0, 4, 8], # left_diagonal
      [6, 4, 2] # right_diagonal
    ]
    @winner = false
    @played_moves = []
  end

  # Checks if the move is between 1 and 9 and if move was already played
  # If the check is passed, replaces the number on the board with the symbol assigned to the player
  # Also adds move to played moves
  def register_move(position, symbol)
    return 0 unless position.between?(1, 9) && !played_moves.include?(position)

    board.each_with_index do |x, i|
      x.each_with_index do |y, j|
        (board[i][j] = symbol) && played_moves.push(position) if y == position.to_s
      end
    end
    1
  end

  # Checks if there is a winner, called after each round
  # Checks if any combination currently on board matches any combination in the array of winning combinations
  def has_winner?
    winmap = win_combinations.map { |w| board.flatten.values_at(*w) }
    @winner = true if winmap.any? { |combination| combination.all?('X') || combination.all?('O') }
  end

  # Updates the board
  # This method is necessary given that each time a move is made a new board is made in the memory
  # This means that if we call the board representation it calls the representation of the original board
  def update_board(updated_board)
    @board_representation = " #{updated_board[0][0]} | #{updated_board[0][1]} | #{updated_board[0][2]} " + "\n" \
                            '---+---+---' + "\n" \
                            " #{updated_board[1][0]} | #{updated_board[1][1]} | #{updated_board[1][2]} " + "\n" \
                            '---+---+---' + "\n" \
                            " #{updated_board[2][0]} | #{updated_board[2][1]} | #{updated_board[2][2]} "
  end
end
