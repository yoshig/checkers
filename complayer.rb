class ComputerPlayer

  def initialize(board, color)
    @board, @color = board, color
  end

  def moves
    best_moves = find_all_moves.sort { |x, y| x.count <=> y.length }
    best_moves.last
  end

  def find_all_valid_moves
    
  end

  def all_my_pieces
    @board.pieces.select { |piece| piece.color == @color }
  end

  def make_move_chain(start_chain)
    cont_chain = start_chain.dup
  end
end