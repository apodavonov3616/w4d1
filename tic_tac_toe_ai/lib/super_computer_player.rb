require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    instance = TicTacToeNode.new(game.board, mark)
    instance.children.each do |child|
      if child.winning_node?(mark)
        return child.prev_move_pos
      end
    end
    instance.children.each do |child|
      if child.losing_node?(mark) == false
        return child.prev_move_pos
      end
    end
    raise "error"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
