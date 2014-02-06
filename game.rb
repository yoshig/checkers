require_relative './board'
require_relative './piece'
require_relative './errors'

class Game
  def initialize(player1, player2)
    @player1, @player2, = player1, player2
    Board.new(true)
  end
end

a = Board.new(true)
# b = Piece.new(:black, a, [0, 0])
# a[[0, 0]] = b
# c = Piece.new(:red, a, [3, 3])
# a[[3, 3]] = c
# d = Piece.new(:red, a, [1, 1])
# a[[1, 1]] = d

# a.show
# # b.perform_jump([2, 2])
# b.perform_moves([[2, 2], [4, 4], [5, 5]])
# puts ""
a.show