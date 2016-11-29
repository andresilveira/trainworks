require 'spec_helper'

INPUT_FILE_PATH = 'tmp/test_input'.freeze

def write_input_file(text)
  File.open(INPUT_FILE_PATH, 'w+') { |file| file.write(text) }
end

describe Trainworks::FileParser do
  describe '#parse' do
    describe 'when the file is empty' do
      before { write_input_file('') }

      let(:file_parser) { Trainworks::FileParser.new(INPUT_FILE_PATH) }

      it 'returns an empty array' do
        expect(file_parser.parse).to eq([])
      end
    end

    describe 'when the file contain an unknown format' do
      before { write_input_file('A3B, 8CD') }

      let(:file_parser) { Trainworks::FileParser.new(INPUT_FILE_PATH) }

      it 'raises InvalidRailroadInputFormat error' do
        expect { file_parser.parse }.to raise_error(Trainworks::FileParser::InvalidRailroadInputFormat)
      end
    end

    describe 'when the file contain AB1, CD2' do
      before { write_input_file('AB1, CD2') }

      let(:file_parser) { Trainworks::FileParser.new(INPUT_FILE_PATH) }

      it 'returns an array with the routes described' do
        expect(file_parser.parse).to eq [
          %w(A B 1),
          %w(C D 2)
        ]
      end
    end
  end
end
