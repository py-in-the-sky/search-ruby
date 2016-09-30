require 'set'


module GraphSearcher
  class Base
    attr_reader :queue, :search_helper

    def initialize(search_helper:, queue: nil)
      @search_helper = search_helper
      @queue = queue || default_queue
    end

    def find_minimal_path(start_node, target_node)
      # TODO: in general, our target could be any one of a collection of
      # nodes, potentially an infinitely large collection.  In the general
      # case, then, we don't want just `current_node == target_node`; we
      # want a general function that tests whether `current_node` is in a
      # collection of nodes or has all the properties of a target node.

      visited_nodes = Set.new  # Keep track of visited nodes; avoid infinite loops.
      # No need to visit a node twice; the first time you visit a node, it will be
      # on the shortest path from start_node to that node.
      queue.push(make_start_state(start_node))

      until queue.empty?
        search_state = queue.pop
        current_node = search_state.current_node

        return search_state.path if current_node == target_node

        unless visited_nodes.include?(current_node)  # Unless already visited...
          visited_nodes.add(current_node)
          neighboring_nodes(current_node).each do |neighbor_node|
            unless visited_nodes.include?(neighbor_node)  # Unless already visited...
              queue.push(make_next_state(search_state, neighbor_node, target_node))
            end
          end
        end
      end
    end

    def neighboring_nodes(node)
      search_helper.neighboring_nodes(node)  # All nodes adjacent to the current node.
    end
  end

  class SearchState
    attr_reader :path, :current_node

    def initialize(path:)
      @path = path
      @current_node = path.last
    end
  end
end
