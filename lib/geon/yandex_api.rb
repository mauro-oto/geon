module Geon
  class YandexApi
    PATH = '/1.x/'

    # @param [Geon::HttpLoader] downloader
    # @param [Hash] param
    def initialize(downloader, param = {})
      @downloader = downloader

      @general_param = {
          results: 1,
          format:  'json',
          kind:    'house',
      }.merge(param)

    end

    def geocode(args = {})
      param = @general_param
      if args[:lat] and args[:long]
        param[:geocode] = "#{args[:long]},#{args[:lat]}"
      end

      if args[:query]
        param[:geocode] = args[:query]
      end

      response = @downloader.get PATH , param
      result   = JSON.parse(CGI::unescape response)

      result
    end

  end

end