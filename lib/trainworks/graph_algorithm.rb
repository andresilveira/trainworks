# rubocop:disable MethodLength
# rubocop:disable ParameterLists

module Trainworks
  # GraphAlgorithm is used to calculate direct distances,
  # shortest path and other paths between nodes.
  # It assumes graph is a hash of adjacencies of a **directed-positively-weighted-possibly-cyclic-graph**
  # @example Example of a graph
  #   'A' => { 'B' => 5 },
  #   'B' => { 'C' => 5 },
  #   'C' => { 'B' => 4 }
  #
  class GraphAlgorithm
    def initialize(graph)
      @graph = graph
    end

    # @param [Array] cities is a set of nodes
    # @return [Number] the distance traveled from city to city in cities
    # @return [String] "NO SUCH ROUTE" when one of the citis is not connected to another
    # @example
    #   algorithm.distance(['A', 'B', 'C']) => 10
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

    # @param [Object] from the starting point
    # @param [Object] to the goal
    # @param [Number] stops the maximum number of stops between from and to the algorithm is allowed to travel
    # @return [Array<Array>] all possible trips from the starting point to the goal with maximum stops equal to `stops`
    def trips_with_max_stops(from:, to:, stops:, total_paths: [from], solutions: [])
      routes(from).map do |city, _paths|
        return solutions if 0 >= stops
        next_total_paths = [*total_paths, city]
        solutions.push(next_total_paths) if arrived?(city, to)
        trips_with_max_stops(from: city, to: to, stops: stops - 1, total_paths: next_total_paths, solutions: solutions)
      end
      solutions
    end

    # @param [Object] from the starting point
    # @param [Object] to the goal
    # @param [Number] stops the maximum number of stops between from and to the algorithm is allowed to travel
    # @return [Array<Array>] all possible trips from the starting point to the goal with maximum stops equal to `stops`
    # @see GraphAlgorithm#trips_with_max_stops #trips_with_max_stops
    # it calls {trips_with_max_stops} and filter out the trips that don't have the exact number of stops as `stops`
    def trips_with_exact_stops(from:, to:, stops:)
      total_path_size = stops + 1 # a path includes the stops plus the origin
      trips_with_max_stops(from: from, to: to, stops: stops).select do |path|
        path.size == total_path_size
      end
    end

    # @param [Object] from the starting point
    # @param [Object] to the goal
    # @param [Number] max_distance the maximum distance between from and to the algorithm is allowed to travel
    # @return [Array<Array>] all trips from the starting point to the goal with maximum stops equal to `max_distance`
    # Since we calculate the distance by adding up the distances between the nodes, the edges must have positive
    # distances otherwise it's not garateed the algorithm will reach a stop.
    def trips_with_max_distance(from:, to:, max_distance:, total_paths: [from], solutions: {}, current_distance: 0)
      routes(from).map do |city, _paths|
        next_current_distance = current_distance + go(from: from, to: city)
        return solutions.keys if next_current_distance >= max_distance
        next_total_paths = [*total_paths, city]
        solutions[next_total_paths] = next_current_distance if arrived?(city, to)
        trips_with_max_distance(
          from: city,
          to: to,
          max_distance: max_distance,
          total_paths: next_total_paths,
          solutions: solutions,
          current_distance: next_current_distance
        )
      end
      solutions.keys
    end

    # @param [Object] from the starting point
    # @param [Object] to the goal
    # @return [Hash] all possible trips from the starting point to the goal without repeating loops
    def trips(from:, to:, current_distance: 0, current_path: [from], all_paths: {})
      routes(from).map do |city, _paths|
        next_current_path = [*current_path, city]
        next_current_distance = current_distance + go(from: from, to: city)
        all_paths[next_current_path] = next_current_distance if arrived?(city, to)
        next if arrived?(city, to) || already_visited?(next_current_path, city)
        trips(
          from: city,
          to: to,
          current_distance: next_current_distance,
          current_path: next_current_path,
          all_paths: all_paths
        )
      end
      all_paths
    end

    # @param [Object] from the starting point
    # @param [Object] to the goal
    # @return [Number] the shortest distance from `from` to `to`
    # @see GraphAlgorithm#trips #trips
    # @raise NoSuchRoute
    # It calls {trips} to find all paths between the starting point and the goal and returns
    # the shortest distance found. If there's no path between `from` and `to` it raises {NoSuchRoute}
    def shortest_distance(from:, to:)
      shortest_distance = trips(from: from, to: to).values.min
      raise NoSuchRoute if shortest_distance.nil?
      shortest_distance
    end

    # NoSuchRoute is raised when there are no direct connection between two cities (nodes)
    class NoSuchRoute < KeyError
      def to_s
        'NO SUCH ROUTE'
      end
    end

    private

    def arrived?(current, goal)
      current == goal
    end

    # if the current_city can be found more than one time in the path
    # it means we already visited it.
    def already_visited?(path, current_city)
      path.count(current_city) > 1
    end

    # these are helper methods to deal with finding keys in the graph an its value
    # in case of not finding the keys (`from` and `to`) it raises `NoSuchRoute`
    def go(from:, to:)
      routes(from).fetch(to) { raise NoSuchRoute }
    end

    def routes(city)
      @graph.fetch(city) { raise NoSuchRoute }
    end
  end
end
