
describe Geon::Yandex, 'Yandex geocode' do

  it 'Разбор json ответа с одним результатом' do

    loader = double("Geon::HttpLoader")
    loader.stub(:get) { sample('yandex/yandex_geocode1.json') }

    yandex = Geon::Yandex.new(@key, {loader: loader})

    result = yandex.forward(55.757962, 37.611006)

    expected         = Geon::GeoObject.new
    expected.address = 'Россия, Москва, Тверская улица, 7'
    expected.coord   = [55.757962, 37.611006] #long, lat

    expected.to_hash.should eq result.to_hash
  end
end