class YouTube
  require 'Date'

  def initialize(element)
    time = Time.parse(element["published"]["$t"])
  	date = time.strftime("%m %B %Y")
    title = element["title"]["$t"]
  	url = element["link"][0]["href"]
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