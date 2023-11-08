# frozen_string_literal: true

class Board
  attr_accessor :board, :board_representation, :winner

  attr_reader :win_combinations

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
  end

  def register_move(position, symbol)
    0 if position != (1..9)
    board.each do |x|
      puts x
      x.map { |y| y == position.to_s ? symbol : nil }
    end
    1
  end

  def has_winner?
    winmap = win_combinations.map { |w| board.flatten.values_at(*w) }
    pp winmap
    winner = true if winmap.any? { |combination| combination.all?('X') || combination.all?('O') }
  end
end
