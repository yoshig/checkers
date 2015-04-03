checkers
========

This is a simple Checkers game to be played in the console. A user can play against another user in the same console, or against an AI. The AI, admittedly, is not the smartest, but it does make some decisions:

* If there are different jumps available, it will choose the jump that results in the most pieces captured.
* If there is only one jump, it will choose that jump over a normal move.
* If there are no jumps, it will randomly choose a piece to move.

The multi-jump ability for the AI is done recursively. It observes all possible jumps it has available, and each jump, dups the board, tries the move, and looks to see if there are other jumps it can make from the newly acquired position. It was a fun implementation.

Also, in order to move a piece, I created a method called square change, which gets called often when moving and jumping pieces:
 def square_change(square, move)
    square.zip(move).map { |coord| coord.inject(:+) }
  end

Pretty sweet, right?
