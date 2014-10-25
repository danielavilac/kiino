class KiinosController < ApplicationController
  require 'FacebookWrapper'
  require "InstagramWrapper"

  Instagram.configure do |config|
    config.client_id = "86965849d50f4d21bb64aa9b4875497b"
    config.client_secret = "39eebb1fad144dadbe81439ecbc4b5b1"
  end


  def index

    @instagramArray = Array.new()

    client = Instagram.client(:access_token => "1523873280.1fb234f.6c37e727092a4d7ea584e29708c447f7 ")
    tags = client.tag_search('cat')

    if !tags.blank? 
      for media_item in client.tag_recent_media(tags[0].name)
        @instagramArray.push(InstagramWrapper.new(media_item))
      end
    end
  end



  def facebookSearch

    @facebookArray = Array.new  
    Koala.config.api_version = "v1.0"
    oauth_access_token = "CAACEdEose0cBALHDT2xmwyF5Wo8Hq1td0BGN3PNsyl01iljdaMzZAhurpowq1XerrVEmOILipY2r8QZAvKyPJPYzRJbydnxS0H7B4sZBw3xtQzr3o3jvFkxuvhG4ZBPXouker9ZB6pOZAZA5lZCfUEZB5TcoQxsi5QlAsDZA4MD3J9rSNn9ZBIx2IWXSRjHpy6zHleiRmJBxU0L9ZBY4psEZC5xab"
    @graph = Koala::Facebook::API.new(oauth_access_token)
    # profile = @graph.get_object("me")
    # https://graph.facebook.com/search?type=post&q=%23food
    @post  = @graph.get_object("/search?type=post&q=%23food&fields=caption,message,from,picture", {}, api_version: "v1.0")

    @post.each do |element|
      @facebookArray.push(FacebookWrapper.new(element))
    end

  end
end
