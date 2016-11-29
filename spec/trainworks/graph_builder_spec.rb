require 'spec_helper'

describe Trainworks::GraphBuilder do
  let(:builder) { Trainworks::GraphBuilder }

  describe '.add_edge' do
    it 'inserts a new node to the graph if it is not present' do
      graph = {}
      expect(builder.add_edge(graph, 'A', 'B', 10)).to eq(
        'A' => { 'B' => 10 }
      )
    end

    it 'inserts a new edge if the node already exists' do
      graph = { 'A' => { 'B' => 10 } }
      expect(builder.add_edge(graph, 'A', 'C', 20)).to eq(
        'A' => { 'B' => 10, 'C' => 20 }
      )
    end

    it 'overrides an edge if already exists' do
      graph = { 'A' => { 'B' => 10 } }
      expect(builder.add_edge(graph, 'A', 'B', 20)).to eq(
        'A' => { 'B' => 20 }
      )
    end
  end

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
