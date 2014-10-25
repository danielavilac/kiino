class FacebookWrapper
  
  def initialize(element)
    @id = element["id"]
    @author= element["from"]["name"]
    @message = (element["message"].nil? ? (element["caption"].nil? ? "": element["caption"]): element["message"])
    @photo = (element["picture"].nil? ? "" : element["picture"])
    @date = element["created_time"]
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

end
