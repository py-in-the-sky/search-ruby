require_relative 'base'
require_relative '../data_structures/queue'


module GraphSearcher
  class BreadthFirstSearcher < Base
    def search_method_name
      'BFS'
    end

    def default_queue
      Queue.new
    end

    def make_start_state(start_node)
      SearchState.new(path: [ start_node ])
    end

    def make_next_state(state, next_node, _)
      SearchState.new(path: state.path + [ next_node ])
    end
  end
end
