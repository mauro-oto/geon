describe Geon::Yandex, 'Yandex real geocode' do

  it 'Разбор json ответа с одним результатом' do

    yandex = Geon::Yandex.new

    result = yandex.forward(55.757962, 37.611006)

    expected         = Geon::GeoObject.new
    expected.address = 'Россия, Москва, Тверская улица, 7'
    expected.coord   = [55.757962, 37.611006] #long, lat

    expected.to_hash.should eq result.to_hash
  end
end