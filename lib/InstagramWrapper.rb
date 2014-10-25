class InstagramWrapper
  require 'Date'
  
  def initialize(element)
    @id = element.id
    @author= element.user.username
    @tags = element.tags
    sec = element.created_time.to_i / 1000
    time = Time.at(sec)
    @date = time.strftime("%m %B %Y")
    @photo = element.images.standard_resolution.url
    @size = 4
    @mood = nil
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

  def size
    @size
  end
  
  def mood
    @mood
  end

  def data
    @tags.to_s
  end
end
