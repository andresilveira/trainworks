require 'spec_helper'

describe Trainworks::Railroad do
  # examples/input.txt
  # AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7
  let(:railroad) { Trainworks::Railroad.new('examples/input.txt') }

  describe 'The distance of the route' do
    it 'A-B-C is 9' do
      expect(railroad.distance('A-B-C')).to eq(9)
    end

    it 'A-D is 5' do
      expect(railroad.distance('A-D')).to eq(5)
    end

    it 'A-D-C is 13' do
      expect(railroad.distance('A-D-C')).to eq(13)
    end

    it 'A-E-B-C-D is 22' do
      expect(railroad.distance('A-E-B-C-D')).to eq(22)
    end

    it 'A-E-D is NO SUCH ROUTE' do
      expect(railroad.distance('A-E-D')).to eq('NO SUCH ROUTE')
    end
  end

  describe 'The length of the shortest route (in terms of distance to travel)' do
    before { pending 'Not implemented' }

    it 'from A to C is 9' do
      expect(railroad.shortest_distance(from: 'A', to: 'C')).to eq(9)
    end

    it 'from B to B is 9' do
      expect(railroad.shortest_distance(from: 'A', to: 'C')).to eq(9)
    end
  end

  describe 'The number of trips' do
    it 'starting at C and ending at C with a maximum of 3 stops is 2' do
      expect(railroad.trips(from: 'C', to: 'C', with_max_stops: 3).count).to eq(2)
    end

    it 'starting at A and ending at C with exactly 4 stopsis 3' do
      pending 'not implemented'
      expect(railroad.trips(from: 'A', to: 'C', with_exactly_stops: 10).count).to eq(3)
    end

    it 'from C to C with a distance of less than 30 is 7' do
      pending 'not implemented'
      expect(railroad.trips(from: 'A', to: 'B', with_max_distance: 30)).to eq(7)
    end
  end
end
