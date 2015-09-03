# coding: utf-8
require 'cgi'
require 'json'

module Geon
  class WikimapiaApi

    # @param [Geon::HttpLoader] downloader
    # @param [String] service_key
    # @param [Hash] param
    def initialize(downloader, service_key, param = {})
      @downloader, @service_key = downloader, service_key

      @general_param = {
          key:    @service_key,
          format: 'json'
      }.merge(param)

    end

    # @example
    # place_getnearest(55.753141,37.625299) #Red square
    #
    def place_getnearest(lat, lon, category)
      if category
        request 'place.getnearest', {lat: lat, lon: lon, category: category}
      else
        request 'place.getnearest', {lat: lat, lon: lon}
      end
    end

    def place_search(q)
      request 'place.search', {q: q}
    end

    def place_getbyid(id)
      request 'place.getbyid', {id: id}
    end

    def place_getbyarea(lon_min, lat_min, lon_max, lat_max)
      request 'place.getbyarea', {lon_min: lon_min, lat_min: lat_min, lon_max: lon_max, lat_max: lat_max}
    end

    def street_getbyid(id)
      request 'street.getbyid', {id: id}
    end

    def category_getbyid(id)
      request 'category.getbyid', {id: id}
    end

    #50 categories by page
    def category_getall(page = 1, count = 50)
      request 'category.getall', {page: page, count: count}
    end

    def api_getlanguages
      request 'api.getlanguages'
    end


    protected

    def request(function, local_param = {})
      param            = @general_param.merge local_param
      param[:function] = function

      response = @downloader.get '/', param
      result   = JSON.parse(CGI::unescape response)
      check_response(result)
      result
    end


    def check_response(response)
      if response['debug'] && response['debug']['code']
        case response['debug']['code'].to_i
          when 1000
            raise InvalidKeyError
          else
            raise WikimapiaError.new(response['debug']['message']) if response['debug']['message']
            raise WikimapiaError.new('Wikimapia: unknown error')
        end

      end
    end


  end
end
