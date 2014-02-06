#To make it easier for the user, I changed the indeces to be x-y notation
require 'colorize'

class Board
  def initialize(new_board = false)
    @board = Array.new(8) { Array.new(8) }
    
    if new_board
      create_new_board
    end
  end

  def empty_square?(position)
    self[position].nil?
  end

  def show
    print_board = @board.map.with_index do |row, row_ind|
      row.map.with_index do |square, col_ind|
        piece_color = (square.nil? || square.color == :black ? :black : :red)
        sq_color = ((row_ind + col_ind).even? ? :black : :white)
        (square.nil? ? "  " : square.to_s)
        .colorize(:background => sq_color, :color => piece_color)
      end
      .join
    end

    puts print_board
  end

  def [](pos)
    x, y = pos
    @board[7 - x][y]
  end

  def []=(pos, piece)
    y, x = pos
    @board[7 - x][y] = piece
  end

  def create_new_board

  end

end