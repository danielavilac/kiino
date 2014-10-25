class TwitterWrapper
  
  def initialize(element)
    @date = element.created_at.strftime("%d %B %Y")
    @tweet = element.text
    @user = element.user.name
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
  
end
