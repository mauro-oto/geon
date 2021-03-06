describe Geon::WikimapiaApi do
  before(:all) do
    @key = "XXXX"
  end

  it 'Проверка что приходит разобранный json' do
    loader = double("Geon::HttpLoader")
    loader.stub(:get) { sample('wikimapia/place.getbyid__good.json') }

    wikimapia = Geon::WikimapiaApi.new(loader, @key)

    place = wikimapia.place_getbyid(24434033)

    place.should include('id')
  end

  it 'Должно быть исключение, если апи ответило ошибкой' do

    loader = double("Geon::HttpLoader")
    loader.stub(:get) { sample('wikimapia/error__wrong_key.json') }

    wikimapia = Geon::WikimapiaApi.new(loader, @key)

    expect { wikimapia.category_getall() }.to raise_error Geon::InvalidKeyError
  end


  it 'place_getbyarea' do
    loader = double("Geon::HttpLoader")
    loader.stub(:get) { sample('wikimapia/place.getbyarea__good.json') }

    wikimapia = Geon::WikimapiaApi.new(loader, @key)

    places = wikimapia.place_getbyarea(50.0, 50.0, 51.0, 51.0)

    places.should have(5).places
  end

end