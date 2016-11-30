module Trainworks
  class Route
    attr_accessor :from, :to, :distance

    def initialize(from:, to:, distance:)
      self.from     = from.to_s
      self.to       = to.to_s
      self.distance = distance.to_f
    end

    def ==(other)
      from == other.from &&
        to == other.to &&
        distance == other.distance
    end
  end
end
