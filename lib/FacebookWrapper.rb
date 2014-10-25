class FacebookWrapper
  require 'Date'

  def initialize(element)
    @id = element["id"]
    @author= element["from"]["name"]
    @message = (element["message"].nil? ? (element["caption"].nil? ? "": element["caption"]): element["message"])
    @photo = (element["picture"].nil? ? "" : element["picture"])
    time = Time.parse(element["created_time"])
    @date = time.strftime("%m %B %Y")
    @size = 1
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

  def message
    @message
  end

  def photo
    @photo
  end

  def date
    @date
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
      @message
    else
      @transalated_text
    end
  end


end
