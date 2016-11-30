require 'spec_helper'

describe Trainworks::Route do
  let(:route) do
    Trainworks::Route.new(
      from: "A",
      to:   "B",
      distance: 5.6
    )
  end

  it 'responds to "from"' do
    expect(route.from).to eq("A")
  end

  it 'responds to "to"' do
    expect(route.to).to eq("B")
  end

  it 'responds to "distance"' do
    expect(route.distance).to eq(5.6)
  end

  context 'should convert the parameters' do
    let(:route) do
      Trainworks::Route.new(
        from: 15,
        to:   :B,
        distance: "1.6"
      )
    end

    it '"from" is converted to string' do
      expect(route.from).to eq("15")
    end

    it '"to" is converted to string' do
      expect(route.to).to eq("B")
    end

    it '"distance" is converted to float' do
      expect(route.distance).to eq(1.6)
    end
  end
end
