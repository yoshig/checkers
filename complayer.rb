require 'debugger'

class ComputerPlayer

  def get_game_info(board, color)
    @board = board
    @color = color
  end

  def moves
    best_moves.sort! { |x, y| x.count <=> y.count }
    best_moves.last
  end

  def best_moves
    return all_jumps unless all_jumps.empty?
    all_slides
  end

  def all_jumps
    jumps_arr = []
    all_my_pieces.each do |piece|
      jumps_arr << make_move_chain([piece.square], @board)
    end
    # debugger
    jumps_arr
  end

# REPLACED BY BEST JUMP!

  # def all_jumps
  #   [].tap do |jumps_arr|
  #     all_my_pieces.each do |piece|
  #       piece.valid_jumps.each do |jump|
  #         jumps_arr << [piece.square, jump]
  #       end
  #     end
  #   end
  # end

  def make_move_chain(start_chain, duped_board)
    duped_piece = duped_board[start_chain.last]
    return [] if start_chain.size == 1 && duped_piece.valid_jumps.empty?
    return start_chain if duped_piece.valid_jumps.empty?

    longest_move = []
    duped_piece.valid_jumps.each do |jump|
      next_board = duped_board.dup
      next_board[duped_piece.square].perform_jump(jump)
      test_jump = make_move_chain(start_chain + [jump], next_board)
      longest_move = test_jump if test_jump.length > longest_move.length
    end
    longest_move
  end

  def all_slides
    [].tap do |slides_arr|
      all_my_pieces.each do |piece|
        piece.valid_slides.each do |slide|
          slides_arr << [piece.square, slide]
        end
      end
    end
  end

  def all_my_pieces
    @board.pieces.select { |piece| piece.color == @color }
  end
end