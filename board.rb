# frozen_string_literal: true

class Board
  attr_accessor :board, :board_representation
  attr_reader :win_array

  def initialize
    @board = %w[1 2 3 4 5 6 7 8 9]
    @board_representation = " #{board[0]} | #{board[1]} | #{board[2]} " + "\n" \
                            '---+---+---' + "\n" \
                            " #{board[3]} | #{board[4]} | #{board[5]} " + "\n" \
                            '---+---+---' + "\n" \
                            " #{board[6]} | #{board[7]} | #{board[8]} "
    @win_array = [
      %w[O X O], # top_row
      %w[X O X], # middle_row
      %w[X O O], # bottom_row
      %w[O X X], # left_column
      %w[X O O], # center_column
      %w[O X O], # right_column
      %w[O O O], # left_diagonal
      %w[X O O] # right_diagonal
    ]
  end

  def register_move(position, symbol)
    0 if position != (1..9)
    board[position - 1] = symbol
    1
  end

  def has_winner?
    true if win_array.any? { |combination| combination.all?('X') || combination.all?('O') }
  end
end
