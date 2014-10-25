class YouTubeWrapper
  require 'Date'

  def initialize(element)
    time = Time.parse(element["published"]["$t"])
  	@date = time.strftime("%m %B %Y")
    @title = element["title"]["$t"]
  	@url = element["link"][0]["href"]
    @size = 4
    @mood = nil
    @language = nil
    @translated_text = nil

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

  def language
    @language
  end

  def transalated_text
    @translated_text
  end

  def data
    if (@language == 'en') 
      @title
    else
      @transalated_text
    end
  end
end
