class ComputerPlayer

  def initialize(board, color)
    @board, @color = board, color
  end

  def moves
    best_moves = find_all_moves.sort { |x, y| x.count <=> y.length }
    best_moves.last
  end

  def find_all_valid_moves
    all_moves = []
  end

  def make_move_chain(start_chain)
    cont_chain = start_chain.dup

    perform_moves(start_chain)
    
  end
end