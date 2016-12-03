module Trainworks
  # Route is used to group together the information
  # of an edge of a graph. From and To are two nodes
  # and distance is the weight between them
  class Route
    attr_accessor :from, :to, :distance

    # @param [Object] from is the starting point of the route
    # @param [Object] to is the end point of the route
    # @param [Object] distance also known as *weight* between `from` and `to`
    # @return [Route]
    # `from` and `to` must respond to `#to_s` and `distance` must respond to `#to_f`
    def initialize(from:, to:, distance:)
      self.from     = from.to_s
      self.to       = to.to_s
      self.distance = distance.to_f
    end

    # @param [Object] other
    # @return [Boolean]
    # Returns `true` if `other.from`, `other.to` and `other.distance` have the same value as `self`
    def ==(other)
      from == other.from &&
        to == other.to &&
        distance == other.distance
    end
  end
end
