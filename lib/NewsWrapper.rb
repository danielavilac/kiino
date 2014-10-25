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
