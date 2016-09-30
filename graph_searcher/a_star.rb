require_relative 'base'
require_relative '../data_structures/heap'


module GraphSearcher
  class AStarSearcher < Base
    def search_method_name
      'A*'
    end

    def default_queue
      Heap.new
    end

    def make_start_state(start_node)
      PrioritizedSearchState.new(path: [ start_node ])
    end

    def make_next_state(state, next_node, target_node)
      new_path = state.path + [ next_node ]

      PrioritizedSearchState.new(
        path: new_path,
        priority: new_path.length + search_helper.underestimate_distance(next_node, target_node)
        # A* heuristic -- the priority we give to a search state.
        # Edit distance from current word to target word will never overestimate
        # the actual distance from the current word to target word.  The idea is
        # that it'll provide a tight underestimate of the distance.
      )
    end
  end

  class PrioritizedSearchState < SearchState
    attr_reader :priority

    def initialize(path:, priority: 0)
      super(path: path)
      @priority = priority
    end

    def <=> (other)
      priority <=> other.priority
    end
  end
end
