module Trainworks
  # GraphAlgorithm is used to calculate direct distances,
  # shortest path and other paths between nodes.
  # It assumes graph is a hash of adjacencies of a directed-weighted-possibly-cyclic-graph
  # @example
  # {
  #   'A' => { 'B' => 5 },
  #   'B' => { 'C' => 5 },
  #   'C' => { 'B' => 4 }
  # }
  # In this graph, the node 'A' is connected to 'B' and have a distance of 5. The node
  # 'B' is connected to 'C' with distance 5 as well. And finally, the node 'C' has a
  # connection to 'B' with distance 4.
  class GraphAlgorithm
    def initialize(graph)
      @graph = graph
    end

    def distance(cities)
      distance = 0
      begin
        cities.each_cons(2) do |(from, to)|
          distance += go(from: from, to: to)
        end
      rescue NoSuchRoute => e
        distance = e.to_s
      end

      distance
    end

    def trips_with_max_stops(from:, to:, stops:, total_paths: [from], solutions: [])
      routes(from).map do |city, _paths|
        return total_paths if stops.negative?
        next_total_paths = [*total_paths, city]
        solutions.push(next_total_paths) if city == to
        trips_with_max_stops(from: city, to: to, stops: stops - 1, total_paths: next_total_paths, solutions: solutions)
      end
      solutions
    end

    # NoSuchRoute is raised when there are no direct connection between two cities (nodes)
    class NoSuchRoute < KeyError
      def to_s
        'NO SUCH ROUTE'
      end
    end

    private

    def routes(city)
      @graph.fetch(city) { raise NoSuchRoute }
    end

    def go(from:, to:)
      routes(from).fetch(to) { raise NoSuchRoute }
    end
  end
end
