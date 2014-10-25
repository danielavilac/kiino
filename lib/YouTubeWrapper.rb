class YouTubeWrapper
  require 'Date'

  def initialize(element)
    time = Time.parse(element["published"]["$t"])
  	@date = time.strftime("%m %B %Y")
    @title = element["title"]["$t"]
  	@url = element["link"][0]["href"]
    @size = 4
    @mood = nil
  end

  def date
  	@date
  end

  def title
  	@title
  end

  def url
  	@url
  end

  def size
    @size
  end

  def mood
    @mood
  end

  def data
    @title
  end
end
