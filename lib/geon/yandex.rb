module Geon
  class Yandex
    HOST = 'geocode-maps.yandex.ru/1.x'

    def initialize(key, args = {})
      loader = args[:loader] ? args[:loader] : HttpLoader.new(HOST)
      @api   = YandexApi.new(loader)

    end

    def forward(lat, long)
      raw        = @api.geocode({lat: lat, long: long})
      geo_object = raw_geo_object raw
      result     = GeoObject.new

      result.address = geo_object['metaDataProperty']['GeocoderMetaData']['text']
      raw_coord      = geo_object['Point']['pos'].split
      result.coord   = [raw_coord[1].to_f, raw_coord[0].to_f]

      result
    end

    def reverse(query)
      raw = @api.geocode({query: query})
      geo_object = raw_geo_object raw
      result     = GeoObject.new

      result.address = geo_object['metaDataProperty']['GeocoderMetaData']['text']
      raw_coord      = geo_object['Point']['pos'].split
      result.coord   = [raw_coord[1].to_f, raw_coord[0].to_f]

      raw
    end

    private

    def raw_geo_object(response)
      response['response']['GeoObjectCollection']['featureMember'][0]['GeoObject']
    end
  end
end
