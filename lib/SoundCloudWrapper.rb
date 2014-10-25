class SoundCloudWrapper
  
  def initialize(element, embed)
    @date = Time.parse(element.created_at).strftime("%d %B %Y")
    @title = element.title
    @user = element.user.username
    @embed_html = embed
    @size = 4
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
end
