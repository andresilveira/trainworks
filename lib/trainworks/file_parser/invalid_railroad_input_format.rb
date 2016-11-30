module Trainworks
  class FileParser
    class InvalidRailroadInputFormat < ArgumentError
      def initialize(route_string)
        @route_string = route_string
      end

      def to_s
        "'#{@route_string}' is not of the form LetterLetterNumber. E.g. AB10"
      end
    end
  end
end
