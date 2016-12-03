module Trainworks
  # GraphBuilder is responsible to transform tuples (in our case Routes)
  # into a Hash which represents a list of adjacencies between the nodes.
  #
  # @todo: encapsulate the idea of a Graph inside a class instead of relying on Hash class.
  module GraphBuilder
    # @param [Array<Route>] routes
    # @return [Hash]
    def self.build(routes)
      routes.reduce({}) do |graph, route|
        add_edge(graph, route.from, route.to, route.distance)
      end
    end

    # @param [Hash] graph
    # @param [Object] from
    # @param [Object] to
    # @param [Object] distance
    # @return [Hash] graph with the new edge
    # Adds a new edge to the graph.
    # It checks if the key `from` (*node*) is present in the graph and adds to it the `to` with its distance.
    def self.add_edge(graph, from, to, distance)
      if graph.key?(from)
        graph[from][to] = distance
      else
        graph[from] = Hash[to, distance]
      end
      graph
    end
  end
end
