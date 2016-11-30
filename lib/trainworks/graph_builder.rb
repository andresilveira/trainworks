module Trainworks
  # GraphBuilder is responsible to transform tuples (in our case Routes)
  # into a Hash which represents a list of adjacencies between the nodes.
  module GraphBuilder
    def self.build(routes)
      routes.reduce({}) do |graph, route|
        add_edge(graph, route.from, route.to, route.distance)
      end
    end

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
