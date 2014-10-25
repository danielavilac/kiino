class KiinosController < ApplicationController
  require 'FacebookWrapper'
  require "InstagramWrapper"

  Instagram.configure do |config|
    config.client_id = ENV['INSTRAGRAM_CLIENT_ID']
    config.client_secret = ENV['INSTAGRAM_CLIENT_SECRET']
  end


  def index(keyword)

    instagramArray = Array.new()

    client = Instagram.client(:access_token => ENV['INSTAGRAM_ACCESS_TOKEN'])
    tags = client.tag_search(keyword)

    if !tags.blank? 
      for media_item in client.tag_recent_media(tags[0].name)
        instagramArray.push(InstagramWrapper.new(media_item))
      end
    end

    instagramArray

  end


  def facebookSearch(keyword)

    facebookArray = Array.new  
    Koala.config.api_version = "v1.0"
    oauth_access_token = ENV['FACEBOOK_ACCESS_TOKEN']
    @graph = Koala::Facebook::API.new(oauth_access_token)
    @post  = @graph.get_object("/search?type=post&q=%23#{keyword}&fields=caption,message,from,picture", {}, api_version: "v1.0")

    @post.each do |element|
      facebookArray.push(FacebookWrapper.new(element))
    end
    facebookArray

  end
end
