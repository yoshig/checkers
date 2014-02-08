require_relative 'board'
require_relative 'piece'
require_relative 'errors'
require_relative 'humanplayer'
require_relative 'complayer'

class Game

  attr_accessor :board

  def initialize(player1, player2)
    @player1, @player2, = player1, player2
    @board = Board.new(true)
    @players = [@player1, @player2]
  end

  def show_players_board_and_color
    @players.each do |player|
      if player.is_a?(ComputerPlayer)
        player.get_game_info(@board, color_of(player))
      end 
    end
  end

  def color_of(player)
    team_colors = { @player1 => :black, @player2 => :red }
    team_colors[player]
  end

  def won?
    @players.each do |player|
      if @board.team_eradicated?(color_of(player))
        winning_color = colof_of(player) == :red ? :white : :red
        puts "#{winning_color} wins!"
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
    show_players_board_and_color
    until won?
      @board.show
      player_takes_turn
    end
    @board.show
  end
end

w = ComputerPlayer.new
# a = Game.new(HumanPlayer.new, w)
a = Board.new
b = Piece.new(:black, a, [0, 1])
a[[0, 1]] = b
c = Piece.new(:red, a, [1, 2])
a[[1, 2]] = c
d = Piece.new(:red, a, [1, 4])
a[[1, 4]] = d
e = Piece.new(:black, a, [2, 1])
a[[2, 1]] = e
a.show
w.get_game_info(a, :black)
p w.moves