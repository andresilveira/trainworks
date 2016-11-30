module Trainworks
  class Route
    attr_accessor :from, :to, :distance

    def initialize(from:, to:, distance:)
      self.from     = from.to_s
      self.to       = to.to_s
      self.distance = distance.to_f
    end

    def ==(another_route)
      from == another_route.from &&
      to == another_route.to &&
      distance == another_route.distance
    end
  end
end
