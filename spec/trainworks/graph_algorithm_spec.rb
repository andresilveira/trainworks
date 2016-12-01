require 'spec_helper'

describe Trainworks::GraphAlgorithm do
  let(:graph) { Hash.new }
  let(:algorithm) { Trainworks::GraphAlgorithm.new(graph) }

  context 'when the graph is empty' do
    describe 'simple distance' do
      it 'returns NO SUCH ROUTE' do
        expect(algorithm.distance(%w(A B))).to eq('NO SUCH ROUTE')
      end
    end
  end

  context 'when the graph is not empty' do
    let(:graph) do
      {
        'A' => { 'B' => 5 },
        'B' => { 'C' => 5 },
        'C' => { 'A' => 1, 'D' => 1},
        'D' => { 'A' => 1 }
      }
    end

    describe 'simple distance' do
      context 'when the route exists' do
        it 'returns the distance between two adjacent cities' do
          expect(algorithm.distance(%w(A B))).to eq(5)
        end

        it 'returns the distance between cities even if they are not adjacent' do
          expect(algorithm.distance(%w(A B C))).to eq(10)
        end
      end

      context 'when the route doesnt exist' do
        it 'returns NO SUCH ROUTE' do
          expect(algorithm.distance(%w(A Z))).to eq('NO SUCH ROUTE')
        end
      end
    end

    describe 'trips_with_max_stops' do
      context 'from B to A' do
        let(:trips) { algorithm.trips_with_max_stops(from: 'B', to: 'A', stops: stops) }

        context 'when stops is equal -1' do
          let(:stops) { -1 }

          it 'is none' do
            expect(trips).to be_empty
          end
        end

        context 'when stops is equal 0' do
          let(:stops) { 0 }

          it 'is none' do
            expect(trips).to be_empty
          end
        end

        context 'when stops is equal 1' do
          let(:stops) { 1 }

          it 'is none' do
            expect(trips).to be_empty
          end
        end

        context 'when stops is equal 2' do
          let(:stops) { 2 }

          it 'returns one route ["B", "C", "A"]' do
            expect(trips).to eq([%w(B C A)])
          end
        end

        context 'when stops is equal 3' do
          let(:stops) { 3 }

          it 'returns two routes ["B", "C", "A"] and ["B", "C", "D", "A"]' do
            expect(trips).to eq([%w(B C A), %w(B C D A)])
          end
        end

        context 'when stops is equal 4' do
          let(:stops) { 4 }

          it 'returns two routes ["B", "C", "A"] and ["B", "C", "D", "A"]' do
            expect(trips).to eq([%w(B C A), %w(B C D A)])
          end
        end
      end
    end

    describe 'trips_with_exact_stops' do
      context 'from B to A' do
        let(:trips) { algorithm.trips_with_exact_stops(from: 'B', to: 'A', stops: stops) }

        context 'when stops is equal -1' do
          let(:stops) { -1 }

          it 'is none' do
            expect(trips).to be_empty
          end
        end

        context 'when stops is equal 0' do
          let(:stops) { 0 }

          it 'is none' do
            expect(trips).to be_empty
          end
        end

        context 'when stops is equal 1' do
          let(:stops) { 1 }

          it 'is none' do
            expect(trips).to be_empty
          end
        end

        context 'when stops is equal 2' do
          let(:stops) { 2 }

          it 'returns one route ["B", "C", "A"]' do
            expect(trips).to eq([%w(B C A)])
          end
        end

        context 'when stops is equal 3' do
          let(:stops) { 3 }

          it 'returns one route ["B", "C", "D", "A"]' do
            expect(trips).to eq([%w(B C D A)])
          end
        end

        context 'when stops is equal 4' do
          let(:stops) { 4 }

          it 'is none' do
            expect(trips).to be_empty
          end
        end
      end
    end
  end
end
