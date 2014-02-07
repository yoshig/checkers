require_relative './board'
require_relative './piece'
require_relative './errors'
require 'debugger'

class Game
  def initialize(player1, player2)
    @player1, @player2, = player1, player2
    Board.new(true)
  end

  def play
  end
end

a = Board.new
b = Piece.new(:black, a, [4, 6])
a[[4, 6]] = b
p b.square
c = Piece.new(:red, a, [6, 6])
a[[6, 6]] = c
d = Piece.new(:red, a, [1, 1])
a[[1, 1]] = d

a.show
p "KING? #{b.is_king}"
# b.perform_jump([2, 2])
p b.valid_slides
puts "B: #{b}"
b.perform_moves([[5, 7]])
p "KING? #{b.is_king}"
puts ""
a.show
p b.valid_jumps
b.perform_moves([[7, 5]])
a.show