# coding: utf-8

module Geon
  class Wikimapia

    HOST = 'api.wikimapia.org'

    def initialize(key, args = {})
      loader = args[:loader] ? args[:loader] : HttpLoader.new(HOST)
      @api   = WikimapiaApi.new(loader, key)

    end

    def nearest_places(lat, long, category = nil)
      raw    = @api.place_getnearest(lat, long, category)
      places = raw['places']

      places
    end

    def place(id)
      @api.place_getbyid(id)
    end


    def places_on_area(lon_min, lat_min, lon_max, lat_max)
      raw    = @api.place_getbyarea(lon_min, lat_min, lon_max, lat_max)
      places = raw['places']

      places
    end

    # doesn't work
    def search_places(query)
      raw    = @api.place_search(query)
      places = raw['places']

      places
    end


    def categories
      raw = @api.category_getall
      categories = raw['categories']

      categories
    end

    def street(id)
      @api.street_getbyid(id)
    end

    def category(id)
      raw = @api.category_getbyid(id)

      raw['category']
    end

    def languages
      raw = @api.api_getlanguages

      raw['languages']
    end
  end

end
