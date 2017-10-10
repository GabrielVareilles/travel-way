require "open-uri"
require "nokogiri"


class FetchRome2RioService

  def initialize(startpoint, endpoint)
    @id = ENV['ROME2RIO_KEY']
    @startpoint = startpoint
    @endpoint = endpoint
  end

  def call
    url = "http://free.rome2rio.com/api/1.4/xml/Search?key=#{@id}&oName=#{@startpoint}&dName=#{@endpoint}"
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
  end

end


