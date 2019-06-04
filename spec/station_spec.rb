require 'station'

describe Station do

  before(:each) do
    @station = Station.new('Station1' , 2)
  end

  it 'should return a name' do
    expect(@station.name).to eq('Station1')
  end

  it 'should return a zone' do
    expect(@station.zone).to eq(2)
  end

end