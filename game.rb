require_relative './board'
require_relative './piece'
require_relative './errors'
require_relative './humanplayer'
require_relative './complayer'

class Game
  def initialize(player1, player2)
    @player1, @player2, = player1, player2
    @board = Board.new(true)
    @players = [@player1, @player2]
  end

  def color_of(player)
    team_colors = { @player1 => :black, @player2 => :red }
    team_colors[player]
  end

  def won?
    @players.each do |player|
      if @board.team_eradicated?(color_of(player))
        puts "#{color_of(player)} wins!"
        return true
      end
    end
    false
  end

  def player_takes_turn
    whos_turn = @players[0]
    puts "#{color_of(whos_turn)}'s turn"
    begin
      player_input = whos_turn.moves
      move_piece(player_input)
    rescue => e
      puts e
      retry
    end
    @players.rotate!
  end

  def move_piece(move_array)
    start_piece = @board[move_array.shift]
    check_valid_start_piece(start_piece)    
    start_piece.perform_moves(move_array)
  end

  def check_valid_start_piece(start_piece)
    if start_piece.nil?
      raise InputError.new "You need to choose a correct space"
    elsif start_piece.color != color_of(@players[0])
      raise InputError.new "You must move your own piece"
    end
  end

  def play
    until won?
      @board.show
      player_takes_turn
    end
  end
end

a = Game.new(HumanPlayer.new, HumanPlayer.new)
a.play

# a = Board.new(true)
# a.show
# b = Piece.new(:black, a, [2, 5], true)
# a[[2, 5]] = b
# p b.square
# c = Piece.new(:red, a, [3, 6])
# a[[3, 6]] = c
# d = Piece.new(:red, a, [9, 1])
# a[[0, 1]] = d

# a.show
# p "KING? #{b.is_king}"
# # b.perform_jump([2, 2])
# p b.valid_slides
# puts "B: #{b}"
# b.perform_moves([[4, 7]])
# p "KING? #{b.is_king}"
# puts ""
# a.show
# p b.valid_jumps
# b.perform_moves([[7, 5]])
# a.show