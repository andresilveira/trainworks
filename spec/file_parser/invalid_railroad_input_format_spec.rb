require 'spec_helper'

describe Trainworks::FileParser::InvalidRailroadInputFormat do
  let(:route_string)  { "A1B" }
  let(:exception) { Trainworks::FileParser::InvalidRailroadInputFormat.new(route_string) }

  it 'shows what was the route that generated the exception' do
    expect{ raise exception }.to raise_error(
      '\'A1B\' is not of the form LetterLetterNumber. E.g. AB10'
    )
  end
end
