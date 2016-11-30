module Trainworks
  class GraphAlgorithm
    def initialize(graph)
      @graph = graph
    end

    def distance(route_string)
      distance = 0
      cities = route_string.split('-')
      begin
        cities.each_cons(2) do |cities_pair|
          distance += go(from: cities_pair.first, to: cities_pair.last)
        end
      rescue NoSuchRoute => e
        distance = e.to_s
      end

      distance
    end

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
