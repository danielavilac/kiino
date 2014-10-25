class TwitterWrapper
  
  def initialize(element)
    @date = element.created_at.strftime("%d %B %Y")
    @tweet = element.text
    @user = element.user.name
    @size = 1
    @mood = nil

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

  def data
    @tweet
  end
  
end
