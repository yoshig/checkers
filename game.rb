require_relative './board'
require_relative './piece'
require_relative './errors'

class Game
end

a = Board.new
b = Piece.new(:black, a, [0, 0])
a[[0, 0]] = b
c = Piece.new(:red, a, [3, 3])
a[[3, 3]] = c
d = Piece.new(:red, a, [1, 1])
a[[1, 1]] = d

a.show
# b.perform_jump([2, 2])
b.perform_moves!([])
puts ""
a.show