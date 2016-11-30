module Trainworks
  class Railroad
    def initialize(file_path, file_parser: FileParser, graph_builder: GraphBuilder, graph_algorithm: GraphAlgorithm)
      @file_parser = file_parser.new(file_path)
      @graph = graph_builder.build(@file_parser.parse)
      @algorithm = graph_algorithm.new(@graph)
    end

    def distance(route_string)
      @algorithm.distance(route_string.split('-'))
    end
  end
end
