class NewsWrapper
  def initialize(element)
    time = Time.parse(element["publishedDate"])
    @date = time.strftime("%m %B %Y")
  	@title = element["titleNoFormatting"]
  	@url = element["unescapedUrl"]
    @size = 1
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
  
  def language=(text)
    @language = text
  end
  
  def language
    @language
  end

  def translated_text
    @translated_text
  end

  def data
    @title
  end

  def data=(text)
     @translated_text = text
  end

 
end
