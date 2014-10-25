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
    @language = nil
    @translated_text = nil
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

  def language
    @language
  end

  def transalated_text
    @translated_text
  end

  def data
    if (@language == 'en') 
      @tags.to_s
    else
      @transalated_text
    end
  end
end
