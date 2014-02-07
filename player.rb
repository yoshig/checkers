require_relative './errors'

class HumanPlayer
  X_COORD = ("a".."h").to_a
  Y_COORD = ("1".."8").to_a

  def moves
    begin
      explain_move_entry
      user_input = gets.chomp.split("-")
      final_answer = convert_to_computer_coordinates(user_input)
      check_entry_validity(final_answer)
      user_input
    rescue => e
      puts e
      retry
    end
  end

  def explain_move_entry
    puts "Enter a move (or string of moves if you wish to jump)"
    puts "Enter a dash between your moves"
  end

  def convert_to_computer_coordinates(user_input)
    split_entry_to_arrays(user_input)

    user_input.map! do |x_idx, y_idx|
      [X_COORD.index(x_idx), Y_COORD.index(y_idx)]
    end
  end

  def split_entry_to_arrays(user_input)
    user_input.map! { |entry| entry.split(//) }
  end

  def check_entry_validity(user_input)
    if user_input.any? { |x_idx, y_idx| x_idx.nil? || y_idx.nil? }
      raise InputError.new "Not a valid input"
    end
  end
end

# x = Player.new
# x.moves