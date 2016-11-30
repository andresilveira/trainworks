require 'spec_helper'

describe Trainworks::GraphAlgorithm do
  let(:graph){ Hash.new }
  let(:algorithm) { Trainworks::GraphAlgorithm.new(graph) }

  context 'when the graph is empty' do
    describe 'simple distance' do
      it 'returns NO SUCH ROUTE' do
        expect(algorithm.distance('A-B')).to eq('NO SUCH ROUTE')
      end
    end
  end

  context 'when the graph is not empty' do
    let(:graph) do
      {
        'A' => { 'B' => 5 },
        'B' => { 'C' => 5 }
      }
    end

    describe 'simple distance' do
      context 'when the route exists' do
        it 'returns the distance between two adjacent cities' do
          expect(algorithm.distance('A-B')).to eq(5)
        end

        it 'returns the distance between cities even if they are not adjacent' do
          expect(algorithm.distance('A-C')).to eq(10)
        end
      end

      context 'when the route doesnt exist' do
        it 'returns NO SUCH ROUTE' do
          expect(algorithm.distance('A-Z')).to eq('NO SUCH ROUTE')
        end
      end
    end
  end
end
