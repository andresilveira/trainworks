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

    describe 'trips' do
      it 'with_max_stops raises NO SUCH ROUTE' do
        expect do
          algorithm.trips_with_max_stops(from: 'A', to: 'B', stops: 5)
        end.to raise_error(Trainworks::GraphAlgorithm::NoSuchRoute)
      end

      it 'with_exact_stops raises NO SUCH ROUTE' do
        expect do
          algorithm.trips_with_exact_stops(from: 'A', to: 'B', stops: 5)
        end.to raise_error(Trainworks::GraphAlgorithm::NoSuchRoute)
      end

      it 'with_max_distance raises NO SUCH ROUTE' do
        expect do
          algorithm.trips_with_max_distance(from: 'A', to: 'B', max_distance: 5)
        end.to raise_error(Trainworks::GraphAlgorithm::NoSuchRoute)
      end
    end

    describe 'shortest_distance' do
      it 'returns NO SUCH ROUTE' do
        expect { algorithm.shortest_distance(from: 'A', to: 'B') }.to raise_error(
          Trainworks::GraphAlgorithm::NoSuchRoute
        )
      end
    end
  end

  context 'when the graph is not empty' do
    let(:graph) do
      {
        'A' => { 'B' => 5 },
        'B' => { 'C' => 5 },
        'C' => { 'A' => 1, 'D' => 1 },
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

          it 'returns one route ["B", "C", "A"]' do
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

    describe 'trips_with_max_distance' do
      context 'from B to A' do
        let(:trips) { algorithm.trips_with_max_distance(from: 'B', to: 'A', max_distance: max_distance) }

        context 'when max_distance is negative' do
          let(:max_distance) { -1 }

          it 'is none' do
            expect(trips).to be_empty
          end
        end

        context 'when max_distance is equal 0' do
          let(:max_distance) { 0 }

          it 'is none' do
            expect(trips).to be_empty
          end
        end

        context 'when max_distance is equal 6' do
          let(:max_distance) { 6 }

          it 'is none' do
            expect(trips).to be_empty
          end
        end

        context 'when max_distance is equal 7' do
          let(:max_distance) { 7 }

          it 'returns one route ["B", "C", "A"]' do
            expect(trips).to eq([%w(B C A)])
          end
        end

        context 'when max_distance is equal 8' do
          let(:max_distance) { 8 }

          it 'returns two routes ["B", "C", "A"] and ["B", "C", "D", "A"]' do
            expect(trips).to eq([%w(B C A), %w(B C D A)])
          end
        end

        context 'when max_distance is equal 9' do
          let(:max_distance) { 9 }

          it 'returns two routes ["B", "C", "A"] and ["B", "C", "D", "A"]' do
            expect(trips).to eq([%w(B C A), %w(B C D A)])
          end
        end
      end
    end

    describe 'shortest_distance' do
      subject(:shortest_distance) { algorithm.shortest_distance(from: from, to: to) }

      context 'from A' do
        let(:from) { 'A' }

        context 'to B' do
          let(:to) { 'B' }

          it { is_expected.to eq(5) }
        end

        context 'to C' do
          let(:to) { 'C' }

          it { is_expected.to eq(10) }
        end

        context 'to D' do
          let(:to) { 'D' }

          it { is_expected.to eq(11) }
        end

        context 'to A' do
          let(:to) { 'A' }

          it { is_expected.to eq(11) }
        end

        context 'to an unreacheable city Z' do
          let(:to) { 'Z' }

          it 'should raise an error of no such route' do
            expect { shortest_distance }.to raise_error(Trainworks::GraphAlgorithm::NoSuchRoute)
          end
        end
      end
    end
  end
end
