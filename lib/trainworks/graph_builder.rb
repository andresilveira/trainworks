module Trainworks
  # GraphBuilder is responsible to transform tuples (in our case Routes)
  # into a Hash which represents a list of adjacencies between the nodes.
  module GraphBuilder
    def self.build(tuples)
      # TODO: refactor tuple to be a Route struct or something similar
      tuples.reduce({}) do |graph, tuple|
        from, to, distance = tuple
        assert_route_is_valid([from, to, distance])
        add_edge(graph, from, to, distance)
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

    class UnknwonRouteFormat < ArgumentError; end

    private_class_method

    def self.assert_route_is_valid(route)
      raise UnknwonRouteFormat if route.any?(&:nil?)
    end
  end
end