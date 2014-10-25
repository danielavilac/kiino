class News
  def initialize(element)
    time = Time.parse(element["publishedDate"])
    date = time.strftime("%m %B %Y")
  	title = element["titleNoFormatting"]
  	url = element["unescapedUrl"]
  end

  def date
  	date
  end

  def title
  	title
  end

  def url
  	url
  end
end