module Trainworks
  module GraphBuilder
    def self.build(tuples)
      # TODO: refactor tuple to be a Route struct or something similar
      tuples.reduce({}) do |graph, tuple|
        from, to, distance = tuple
        raise UnknwonRouteFormat if [from, to, distance].any?(&:nil?)
        if graph.has_key?(from)
          graph[from][to] = distance
        else
          graph[from] = Hash[to, distance]
        end
        graph
      end
    end

    class UnknwonRouteFormat < ArgumentError; end
  end
end
