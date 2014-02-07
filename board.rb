#To make it easier for the user, I changed the indeces to be x-y notation
require 'colorize'

class Board

  attr_accessor :board

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
      "#{(8 - row_ind)} " + row.map.with_index do |square, col_ind|
        piece_color = (square.nil? || square.color == :black ? :black : :red)
        sq_color = ((row_ind + col_ind).odd? ? :black : :white)
        (square.nil? ? "    " : square.to_s)
        .colorize(:background => sq_color, :color => piece_color)
      end
      .join
    end
    puts print_board
    puts "   " + ("a".."h").to_a.join("   ")

  end

  def [](pos)
    y, x = pos
    @board[7 - x][y]
  end

  def []=(pos, piece)
    y, x = pos
    @board[7 - x][y] = piece
  end

  def pieces
    @board.flatten.compact
  end

  def team_eradicated?(player_color)
    pieces.none? { |piece| piece.color == player_color }
  end

  def create_new_board
    (0..7).each do |row_idx|
      (0..7).each do |col_idx|
        if (row_idx + col_idx).odd?
          if row_idx < 3
            self[[col_idx, row_idx]] =
              Piece.new(:black, self, [col_idx, row_idx]) 
          elsif row_idx > 4
            self[[col_idx, row_idx]] =
              Piece.new(:red, self, [col_idx, row_idx]) 
          end
        end
      end
    end
  end

end