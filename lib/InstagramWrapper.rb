class InstagramWrapper
  
  def initialize(element)
    @id = element.id
    @author= element.user.username
    @tags = element.tags
    @date = element.created_time
    @photo = element.images.standard_resolution.url
  end

  def id
    @id
  end 

  def author
    @author
  end

  def tags
    @tags.to_s
  end

  def date
    @date
  end

  def photo
    @photo
  end

end
