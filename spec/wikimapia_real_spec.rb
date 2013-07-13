describe 'Real wikimapia' do

  def wikimapia
    unless defined? WIKIMAPIA_KEY
      pending "For real test need set service key. Set const WIKIMAPIA_KEY"
    end

    Geon::Wikimapia.new WIKIMAPIA_KEY
  end

  it 'nearest_places' do
    places = wikimapia.nearest_places(55.814447, 37.626651)
    places.should have_at_least(1).places
  end

  it 'place' do
    id = 24434033
    place = wikimapia.place(id)
    place.should include('id')
    place['id'].to_i.should eq id
  end


  it 'places_on_area' do
    places = wikimapia.places_on_area(50.0, 50.0, 51.0, 51.0)
    places.should have_at_least(1).places
  end

  it 'search_places' do
    pending 'Service doesn\'t work with 1803:Invalid input coordinates'
    places = wikimapia.search_places('Звездный бульвар')
    places.should have_at_least(1).places
  end

  it 'categories' do
    categories = wikimapia.categories
    categories.should have_at_least(1).categories
  end

  it 'street' do
    id = 187960
    street = wikimapia.street(id)
    street.should include('id')
    street['id'].to_i.should eq id
  end

  it 'category' do
    id = 1
    category = wikimapia.category(id)
    category.should include('id')
    category['id'].to_i.should eq id
  end

  it 'languages' do
    id = 1
    languages = wikimapia.languages
    languages.should include('en')
  end

end