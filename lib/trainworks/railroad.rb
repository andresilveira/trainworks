module Trainworks
  # Railroad is the entry point for Trainworks gem
  class Railroad
    # @param [String] file_path is the path for the input file containing the graph definition
    # @param [Object] file_parser is the class responsible for parsing the input file and return a set of {Route}s
    # @param [Object] graph_builder receives the set of {Route}s and build a graph for `graph_algorithm`
    # @param [Object] graph_algorithm is the responsible for calculating the distances between nodes, paths, etc.
    def initialize(file_path, file_parser: FileParser, graph_builder: GraphBuilder, graph_algorithm: GraphAlgorithm)
      @file_parser = file_parser.new(file_path)
      @graph = graph_builder.build(@file_parser.parse)
      @algorithm = graph_algorithm.new(@graph)
    end

    # @param [String] route_string represents the route to be followed. E.g. A-B-C
    # @return [Number] the distance from A to B to C
    # Calculates the distance traveled between cities in the form of `"A-B-C"`
    def distance(route_string)
      @algorithm.distance(route_string.split('-'))
    end

    # @param [Object] from is the starting point
    # @param [Object] to is the goal
    # @param [Number] with_max_stops how many stops at most, the algorithm is allowed to *travel*.
    # @param [Number] with_exact_stops how many stops exactly, the algorithm is allowed to *travel*.
    # @param [Number] with_max_distance the maximum distance (non inclusive), the algorithm is allowed to *travel*
    # @return [Array<Array>] which represents each path found
    # Notice that only one of the parameters `with_max_stops`, `with_exact_stops` or `with_max_distance` will be taken
    # into account, in the following order:
    #
    # 1. `with_max_stops`
    # 2. `with_exact_stops`
    # 3. `with_max_distance`
    def trips(from:, to:, with_max_stops: nil, with_exact_stops: nil, with_max_distance: nil)
      if with_max_stops
        @algorithm.trips_with_max_stops(from: from, to: to, stops: with_max_stops)
      elsif with_exact_stops
        @algorithm.trips_with_exact_stops(from: from, to: to, stops: with_exact_stops)
      elsif with_max_distance
        @algorithm.trips_with_max_distance(from: from, to: to, max_distance: with_max_distance)
      else
        raise "I don't know how to calculate these routes"
      end
    end

    # @param [Object] from is the starting point
    # @param [Object] to is the goal
    # @return [Number] the shortest distance between `from` and `to`
    # Calculates the shortest distance between `from` and `to`
    def shortest_distance(from:, to:)
      @algorithm.shortest_distance(from: from, to: to)
    end
  end
end
