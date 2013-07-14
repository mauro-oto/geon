# coding: utf-8

module Geon
  class GeoObject < ::BasicObject

    attr_accessor :coord, :type, :address, :detail

    def initialize
      @coord   = [0, 0]
      @type    = :house
      @address = ''
      @detail  = {}
    end

    def longitude
      @coord[1]
    end

    def latitude
      @coord[0]
    end

    def to_hash
      {coord: @coord, type: @type, address: @address, detail: @detail}
    end

  end
end