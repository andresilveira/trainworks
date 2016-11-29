require 'spec_helper'

describe Trainworks::GraphBuilder do
  let(:builder) { Trainworks::GraphBuilder }

  describe '.build' do
    context 'when the input is empty' do
      let(:input) { [] }

      it 'returns an empty hash' do
        expect(builder.build(input)).to eq({})
      end
    end

    context 'when the input contain tuples in the form ["A", "B", 1]' do
      let(:input) { [['A', 'B', 1], ['A', 'C', 2], ['B', 'C', 3]] }

      it 'returns a hash representing a list of adjacencies between the nodes' do
        expect(builder.build(input)).to eq(
          'A' => {
            'B' => 1,
            'C' => 2
          },
          'B' => {
            'C' =>  3
          }
        )
      end
    end

    context 'when the input contain tuples in a unknown format' do
      let(:input) { [['A', 'B'], ['C', 2]] }

      it 'raises UnknwonRouteFormat' do
        expect { builder.build(input) }.to raise_error(Trainworks::GraphBuilder::UnknwonRouteFormat)
      end
    end
  end
end
