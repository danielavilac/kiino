class KiinosController < ApplicationController
  

  def index
    soundcloud
  end

  def twitter

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "id0VktxCgF2NqPdLRE5HavArA"
      config.consumer_secret     = "ghxahddWpHnbvihAmIqXdoOEV3xZYvUNREVA4XhOC36Z5CrcBb"
      config.access_token        = "416579684-WycMJorof9IyBzae0gI3DCYgMqrO5rIyZ4xk79q2"
      config.access_token_secret = "r5M3S5HkrOFULUNRnvC5vbvw1pzUuRZZsKgnnHQlBTPQO" 
    end

    tweets_array = Array.new
    search = client.search("#pizza", :result_type => "popular").take(5)
    search.each do |tweet|
      object = {}
      object['date'] = tweet.created_at
      object['tweet'] = tweet.text
      object['user'] = tweet.user.name
      tweets_array.push(object)
    end
    #binding.pry
    #render :json => tweets_array
  end

  def soundcloud
    require 'soundcloud'
    client = Soundcloud.new(:client_id => '5ce969a1c5f4b84e7abe2848d16972c3')
    
    tracks_array = Array.new
    tracks = client.get('/tracks', :q => 'pizza', :licence => 'cc-by-sa', :limit => 1)
    tracks.each do |track|
      object = {}
      object['date'] = track.created_at
      object['title'] = track.title
      object['user'] = track.user.username
      object['embed_info'] = client.get('/oembed', :url => track.uri, :show_comments => false)
      tracks_array.push(object)
    end
    #@result = tracks_array[0]['embed_info']['html'].html_safe
    @result = tracks_array[0]['embed_info']

  end

end
