class NewsWrapper
  def initialize(element)
    time = Time.parse(element["publishedDate"])
    @date = time.strftime("%m %B %Y")
  	@title = element["titleNoFormatting"]
  	@url = element["unescapedUrl"]
    @size = 1
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
end
