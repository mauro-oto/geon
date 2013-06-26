require 'nokogiri'


module Nokogiri::XML

  class Document

    def to_hash
      self.root.element? ? self.root.to_hash : {self.root.name => self.root.text}
    end

  end

  class Element

    def to_hash
      {self.name => self.collect_attributes}
    end

    def collect_attributes
      arr = []
      self.children.each do |child|
        next if child.name == 'text'
        hash = {}
        if child.element? && child.children.length > 1
          hash[child.name] = child.collect_attributes
        else
          hash[child.name] = child.text.strip
        end
        arr << hash
      end
      arr
    end

  end

end

module Geon
  class Wikimapia

    # @param [Cipa::Gateway::Downloader] downloader
    # @param [String] service_key
    def initialize(downloader, service_key)
      @downloader, @service_key = downloader, service_key
    end

    # @example
    # place_getnearest(55.753141,37.625299) #Red square
    #
    def place_getnearest(lat = 0.0, lon = 0.0, service_key = @service_key)
      response = @downloader.get({function: 'place.getnearest', key: service_key, lat: lat, lon: lon})
      reader   = Nokogiri::XML::Reader(response, nil, nil, Nokogiri::XML::ParseOptions::NOBLANKS)

      node = reader.read

      raise 'place.getnearest: wrong response' unless node.name == 'wm'

      # slide cursor
      4.times { reader.read }


      places = []
      place  = {}

      current_place = nil
      loop do

        node = reader.read
        break unless node

        node_name = node.name

        case node_name
          when 'id'
            node       = reader.read
            place[:id] = node.value.to_i
          when 'title'
            node          = reader.read
            place[:title] = node.value
          when 'language'
            node             = reader.read
            place[:language] = node.value
          when 'distance'
            node             = reader.read
            place[:distance] = node.value.to_i
          when 'location'
            place[:location] = parse_location(reader)
          when 'polygon'
            place[:polygon] = parse_polygon(reader)
          else

            if node_name =~ /places_(\d+)/
               if current_place == $1.to_i
                 places << place
               else
                 current_place = $1.to_i
                 place = {}
               end

              next
            end

            reader.read
        end

        reader.read
      end

      places
    end

    def parse_location(reader)
      location = {}
      6.times {
        node                       = reader.read
        location[node.name.to_sym] = reader.read.value.to_f
        reader.read
      }

      location
    end

    def parse_polygon(reader)
      polygon = []

      4.times {
        point = {}
        reader.read

        2.times {
          node      = reader.read
          node_name = node.name

          point[node_name.to_sym] = reader.read.value.to_f
          reader.read
        }

        reader.read

        polygon << point
      }

      polygon
    end

  end

end