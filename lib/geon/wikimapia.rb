# coding: utf-8

module Geon
  class Wikimapia

    HOST = 'api.wikimapia.org'

    def initialize(key, args = {})
      loader = args[:loader] ? args[:loader] : HttpLoader.new(HOST)
      @api   = WikimapiaApi.new(loader, key)

    end

    def nearest_places(lat, long)
      raw    = @api.place_getnearest(lat, long)
      places = raw['places']

      places
    end
  end

end