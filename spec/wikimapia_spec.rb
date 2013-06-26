require 'rspec'
describe 'My behaviour' do
  before(:all) do
    @key = "XXXX"
  end

  it 'should do something' do
    loader = double("Geon::HttpLoader")
    loader.stub(:get) { sample('wikimapia/place.getnearest__good.xml') }

    wikimapia = Geon::Wikimapia.new(loader, @key)

    places = wikimapia.place_getnearest(55.814447, 37.626651)


    expected = {
        id:       24434033,
        title:    'Звёздный бул., 30, корпус 1',
        language: 'ru',
        distance: 10,
        location: {
            north: 55.8146558,
            south: 55.8143825,
            east:  37.626803,
            west:  37.6263677,
            lon:   37.62658535,
            lat:   55.81451915},
        polygon:  [
                      {x: 37.6265575, y: 55.8146559},
                      {x: 37.6263677, y: 55.8145822},
                      {x: 37.6266132, y: 55.8143826},
                      {x: 37.626803, y: 55.8144563},
                  ],
    }

    places.should have(5).places
    places[0].should eq expected
  end
end