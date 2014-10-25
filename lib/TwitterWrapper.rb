class TwitterWrapper
  
  def initialize(element)
    @date = element.created_at.strftime("%d %B %Y")
    @tweet = element.text
    @user = element.user.name
    @size = 1
    @mood = nil
    @language = nil
    @translated_text = nil

  end

  def date
    @date
  end

  def tweet
    @tweet
  end

  def user
    @user
  end
  
  def size
    @size
  end

  def mood
    @mood
  end

  def mood=(moods)
    @mood = moods
  end

  def language
    @language
  end

  def translated_text
    @translated_text
  end

  def data
    @tweet
  end

  def data=(text)
    @translated_text = text
  end

  def language=(text)
    @language = text
  end
  
end
