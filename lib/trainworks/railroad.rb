module Trainworks
  # Railroad is the entry point for Trainworks gem
  # it accepts the path of the input file and optionally
  # a class to parse this file,
  # a class to build the graph
  # and a class that will implement the graph related algorithms
  class Railroad
    def initialize(file_path, file_parser: FileParser, graph_builder: GraphBuilder, graph_algorithm: GraphAlgorithm)
      @file_parser = file_parser.new(file_path)
      @graph = graph_builder.build(@file_parser.parse)
      @algorithm = graph_algorithm.new(@graph)
    end

    # @param [String] a string representing the route to be followed. E.g. A-B-C
    # @return [Number] the distance from A to B to C
    def distance(route_string)
      @algorithm.distance(route_string.split('-'))
    end

    # @param [String] from is the starting point
    # @param [String] to is the goal
    # @param [String] with_max_stops represents how many stops at most, the algorithm is allowed to 'walk'
    # in any direction starting from 'from'
    # @return [Array] a array of arrays which represents each path found
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
  end
end
