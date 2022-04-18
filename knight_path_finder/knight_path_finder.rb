require_relative "../polynodetree/lib/00_tree_node.rb"

class KnightPathFinder

    attr_reader :root_node
    MOVES = [[1,2], [-1,2], [1,-2], [-1,-2], [2,1], [-2,1], [2,-1], [-2,-1]]

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [@root_node.value]
        build_move_tree
    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty?
          check_node = queue.shift
            possible_moves = new_move_positions(check_node.value) #an array possible move is like [1,5]
            possible_moves.each do |possible_move| #[1,5,]
                new_child_node = PolyTreeNode.new(possible_move)
                queue.push(new_child_node)
                check_node.add_child(new_child_node)
                new_child_node.parent = check_node
            end
        end
    end

    def self.valid_moves(pos)
        x, y = pos
        possible_moves = [] #[0,7]
        # return possible_moves unless [0..7].to_a.include?(x) && [0..7].to_a.include?(y)
        MOVES.each {|adder| possible_moves << [adder[0] + x, adder[1] + y]}
        possible_moves.select { |ele| ele.all? { |num| num > -1 && num < 8 } }
    end

    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos) #an array of a bunch of new moves
        moves.reject! {|move| @considered_positions.include?(move)} #reject if repeated
        moves.each {|move| @considered_positions << move unless @considered_positions.include?(move)} #shovel into array of repeats
        moves
    end

    def find_path(end_pos)
        target = root_node.dfs(end_pos)
        trace_path_back(target)
    end

    def trace_path_back(end_pos)
        path = [end_pos]
        # path << path[-1].parent
        # return path.reverse! if path[-1] == root_node
        until path[-1] == root_node
            path << path[-1].parent
        end
        array = []
        path.each do |p|
            array.push(p.value)
        end
        array.reverse!
    end
end 

kpf = KnightPathFinder.new([5,5])