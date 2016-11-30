require 'trainworks/file_parser/invalid_railroad_input_format'

module Trainworks
  # FileParser is responsible for parsing the input file
  # @example
  #   AB5, CD99, CapitalLetterCapitalLetterNumber
  class FileParser
    # captures, for example, AB99
    SINGLE_TUPLE_REGEX = /([A-Z])([A-Z])(\d+)/

    # Converts the object into textual markup given a specific format.
    #
    # @param file_path [String] the path for input file
    def initialize(file_path)
      @raw_content = File.read(file_path)
    end

    # @return [Array] array of tuples in the form ["A", "B", 10] for a tuple AB10
    # @raise [InvalidRailroadInputFormat] if the tuple doesn't match SINGLE_TUPLE_REGEX
    def parse
      clean_string(@raw_content).split(',').map do |route_string|
        matched_route_string = route_string.match(SINGLE_TUPLE_REGEX)
        raise InvalidRailroadInputFormat.new(route_string) if matched_route_string.nil?

      end
    end

    private

    # removes everything from the input except capital letters, numbers and commas
    # @private
    def clean_string(text)
      text.gsub(/[^0-9A-Z\,]/, '')
    end
  end
end
