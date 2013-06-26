module Geon
  class HttpLoader
    def initialize(host, port = 80)
      @http    = Net::HTTP.new(host, port)
      @headers = {
          "Accept"         => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          "Accept-Charset" => "utf-8;q=0.7,*;q=0.3",
          "User-Agent"     => "Geon #{Geon::VERSION}"
      }

    end
  end
end