require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    # @empty_board_node asdfasdfasdfNode
  end

  def losing_node?(evaluator)
    if board.over?
      if board.won? && board.winner != evaluator
        return true
      else
        return false
      end
    end

    multiple_child = self.children
    if evaluator == self.next_mover_mark
      multiple_child.all? {|child| child.losing_node?(evaluator)}
    else
      multiple_child.any? {|child| child.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    if board.over?
      if board.winner == evaluator
        return true
      else
        return false
      end
    end

    multiple_child = self.children
    if evaluator == self.next_mover_mark
      multiple_child.any? {|child| child.winning_node?(evaluator)}
    else
      multiple_child.all? {|child| child.winning_node?(evaluator)}
    end

  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    all_new_pos = []
    (0...3).each do |row|
      (0...3).each do |col|
        pos = [row, col]
        new_board = board.dup #dups the board and set new_board variable to dupped board
        if board.empty?(pos)
          new_board[pos] = next_mover_mark #set the new_board variable's pos to next_mover_mark
          new_mark = next_mover_mark == :x ? :o : :x #set a new mark depending on next_mover_mark's value if it is :x then :o, if it is :o then :x
          new_move = TicTacToeNode.new(new_board, new_mark, pos) #calls tic_tac_toe with the 3 variables being passed in
          all_new_pos << new_move #push the next move into all_new_pos
        end 
      end
    end
    #return the all_new_pos array
    all_new_pos
  end
end
