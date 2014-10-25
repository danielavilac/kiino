class SoundCloudWrapper
  
  def initialize(element, embed)
    @date = Time.parse(element.created_at).strftime("%d %B %Y")
    @title = element.title
    @user = element.user.username
    @embed_html = embed
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
  
  def user
    @user
  end
  
  def embed_html
    @embed_html
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

  def translated_text
    @translated_text
  end

  def data
    @title
  end

  def data=(text)
    @translated_text = text
  end

  def language=(text)
    @language = text
  end
  
end
