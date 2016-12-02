require 'spec_helper'

describe Trainworks::Railroad do
  let(:file_parser)         { double(new: double(parse: true)) }
  let(:graph_builder)       { double(build: true) }
  let(:algorithm_instance)  { double(distance: true) }
  let(:graph_algorithm)     { double(new: algorithm_instance) }

  let(:railroad) do
    Trainworks::Railroad.new(
      'file_name',
      file_parser: file_parser,
      graph_builder: graph_builder,
      graph_algorithm: graph_algorithm
    )
  end

  describe 'calling #distance("A-B-C")' do
    it 'calls distance on its graph_algorithm passing an array as argument' do
      expect(algorithm_instance).to receive(:distance).once.with(%w(A B C))
      railroad.distance('A-B-C')
    end
  end

  describe 'calling #trips(from: "A", to: "B", with_max_stops: 5)' do
    it 'calls trips_with_max_stops on its graph_algorithm passing from, to and stops' do
      expect(algorithm_instance).to receive(:trips_with_max_stops).once.with(
        from: 'A',
        to: 'B',
        stops: 5
      )
      railroad.trips(from: 'A', to: 'B', with_max_stops: 5)
    end
  end

  describe 'calling #trips(from: "A", to: "B", with_exact_stops: 5)' do
    it 'calls trips_with_exact_stops on its graph_algorithm passing from, to and stops' do
      expect(algorithm_instance).to receive(:trips_with_exact_stops).once.with(
        from: 'A',
        to: 'B',
        stops: 5
      )
      railroad.trips(from: 'A', to: 'B', with_exact_stops: 5)
    end
  end

  describe 'calling #trips(from: "A", to: "B", with_max_distance: 5)' do
    it 'calls trips_with_max_distance on its graph_algorithm passing from, to and max_distance' do
      expect(algorithm_instance).to receive(:trips_with_max_distance).once.with(
        from: 'A',
        to: 'B',
        max_distance: 5
      )
      railroad.trips(from: 'A', to: 'B', with_max_distance: 5)
    end
  end

  describe 'calling #shortest_distance(from: "A", to: "B")' do
    it 'calls shortest_distance on its graph_algorithm passing from and to' do
      expect(algorithm_instance).to receive(:shortest_distance).once.with(
        from: 'A',
        to: 'B'
      )
      railroad.shortest_distance(from: 'A', to: 'B')
    end
  end
end
