require 'rspec'
describe Geon::Wikimapia do

  before(:all) do
    @key = "XXXX"
  end
  it 'nearest_places' do
    loader = double("Geon::HttpLoader")
    loader.stub(:get) { sample('wikimapia/place.getnearest__good.json') }

    wikimapia = Geon::Wikimapia.new(@key, {loader: loader})

    places = wikimapia.nearest_places(55.814447, 37.626651)

    expected = {
        'id'       => 24434033,
        'title'    => 'Звёздный бул., 30, корпус 1',
        'language_id' => 1,
        'language' => 'ru',
        'urlhtml' =>
            "<a class=\"wikimapia-link\" href=\"http://wikimapia.org/24434033/ru/Звёздный_бул.,_30,_корпус_1\">Звёздный бул., 30, корпус 1</a>",
        'distance' => 10,
        'location' => {
            'north' => 55.8146558,
            'south' => 55.8143825,
            'east'  => 37.626803,
            'west'  => 37.6263677,
            'lon'   => 37.62658535,
            'lat'   => 55.81451915},
        'polygon'  => [
            {'x' => 37.6265575, 'y' => 55.8146559},
            {'x' => 37.6263677, 'y' => 55.8145822},
            {'x' => 37.6266132, 'y' => 55.8143826},
            {'x' => 37.626803, 'y' => 55.8144563},
        ],
    }

    places.should have(5).places
    places[0].should eq expected
  end
end