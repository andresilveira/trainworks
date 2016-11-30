module Trainworks
  # Route is used to group together the information
  # of an edge of a graph. From and To are two nodes
  # and distance is the weight between them
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
