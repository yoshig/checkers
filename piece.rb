require 'colorize'

class Piece

  attr_reader :color, :is_king
  attr_accessor :square, :board

  def initialize(color, board, square, is_king = false)
    @color, @board, @square, @is_king = color, board, square, @is_king
    
    color_direction = (@color == :black ? 1 : -1)
    @king_moves = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    @pawn_moves = @king_moves.select { |x, y| y == color_direction }
    @moves = @pawn_moves
    @is_king = is_king
  end

  def square_change(square, move)
    square.zip(move).map { |coord| coord.inject(:+) }
  end

  def on_board?(position)
    position.all? { |coord| coord.between?(0, 7) }
  end

  def valid_slides
    [].tap do |slides|
      @moves.each do |move|
        slide_square = square_change(@square, move)
        if on_board?(slide_square) && @board.empty_square?(slide_square)
          slides << slide_square
        end
      end
    end
  end

  def perform_slide(move_to)
    if valid_slides.include?(move_to)
      @board[@square], @board[move_to] = nil, self
      @square = move_to
    end
  end

  def valid_jumps
    [].tap do |jumps|
      @moves.each do |move|
        jumped = square_change(@square, move)
        jump_to = square_change(jumped, move)
        if on_board?(jump_to) && 
             @board.empty_square?(jump_to) &&
             jumpable?(jumped)
          jumps << jump_to
        end
      end
    end
  end

  def jumpable?(square)
    !@board[square].nil? && @board[square].color != @color
  end

  def find_jumped(start_jump, end_jump)
    start_jump.zip(end_jump).map { |coords| coords.inject(:+) / 2}
  end

  def perform_jump(move_to)
    if valid_jumps.include?(move_to)
      jumped = find_jumped(@square, move_to)
      @board[@square], @board[jumped], @board[move_to] = nil, nil, self
      @square = move_to
    end
  end

  def perform_moves!(move_arr)
    raise InvalidMoveError.new "No moves selected" if move_arr.empty?

    if move_arr.length == 1 && valid_slides.include?(move_arr.first)
      perform_slide(move_arr.first)
    else
      until move_arr.empty?
        next_move = move_arr.shift
        if valid_jumps.include?(next_move)
          perform_jump(next_move)
        else
          raise InvalidMoveError.new "Not a valid move!"
        end
      end
    end
  end

  def perform_moves(move_arr)
    #Have to dup the array so perform moves doesn't receive an empty array
    perform_moves!(move_arr) if valid_move_seq?(move_arr.dup)
  end

  def valid_move_seq?(move_arr)
    test_board = board_dup
    test_piece = test_board[@square]
    begin
      test_piece.perform_moves!(move_arr)
    rescue InvalidMoveError => e
      puts e
      false
    else
      true
    end
  end

  def board_dup
    @board.class.new.tap do |new_board|
      @board.pieces.each do |piece|
        new_board[piece.square] =
          piece.class.new(piece.color, new_board, piece.square, piece.is_king)
      end
    end
  end

  def to_s
    icon = @is_king ? "\u26C3" : "\u26C2"
    icon.encode("UTF-8") + " "
  end

end