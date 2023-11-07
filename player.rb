# frozen_string_literal: true

class Player
  attr_accessor :name, :symbol, :winner

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @winner = false
  end
end
