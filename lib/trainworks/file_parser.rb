# I assume the file is formated in the following way:
#   AB5, BC10
# a set of LetterLetterNumber divided by commas

class FileParser
  # captures for example AB99
  SINGLE_TUPLE_REGEX = /([A-Z])([A-Z])(\d+)/

  def initialize(file_path)
    @raw_content = File.read(file_path)
  end

  def parse
    clean_string(@raw_content).split(',').map do |tuple|
      matched_tuple = tuple.match(SINGLE_TUPLE_REGEX)
      raise InvalidRailroadInputFormat if matched_tuple.nil?

      matched_tuple.captures
    end
  end

  class InvalidRailroadInputFormat < ArgumentError; end

  private

  # removes everything from the input except capital letters, numbers and commas
  def clean_string(text)
    text.gsub(/[^0-9A-Z\,]/, '')
  end
end
