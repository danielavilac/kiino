class KiinosController < ApplicationController

  require 'rest_client'
  require 'YouTube'
  require 'News'
  
  YouTubeArray = Array.new
  NewsArray = Array.new
  
  def index
  	@youtube = youtube
  	@news = news
  end

  def youtube
  	uri = "https://gdata.youtube.com/feeds/api/videos?q=surfing&orderby=published&alt=json"
    rest_resource = RestClient::Resource.new(uri)
    users = rest_resource.get
    videos = JSON.parse(users)

    entry = videos["feed"]["entry"]
    entry.each do |element|
    	YouTubeArray.push(YouTube.new(element))
    end

    YouTubeArray
  end

  def news
	uri = "https://ajax.googleapis.com/ajax/services/search/news?v=1.0&q=barack%20obama"
    rest_resource = RestClient::Resource.new(uri)
    users = rest_resource.get
    news = JSON.parse(users)

    entry = news["responseData"]["results"]
    entry.each do |element|
        NewsArray.push(News.new(element))
    end

    NewsArray
  end
end
