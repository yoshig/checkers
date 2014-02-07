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
    [].tap do |jumps_arr|
       all_my_pieces.each do |piece|
        piece.valid_jumps.each do |jump|
          jumps_arr << [piece.square, jump]
       end
     end
    end
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

  def make_move_chain(start_chain)
    cont_chain = start_chain.dup
  end
end