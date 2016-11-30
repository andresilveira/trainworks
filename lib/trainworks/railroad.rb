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
  end
end
