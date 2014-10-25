module ApplicationHelper

  require 'time'
  require 'rest_client'
  require 'YouTube'
  require 'News'
  require 'FacebookWrapper'
  require "InstagramWrapper"
  require 'TwitterWrapper'
  require 'SoundCloudWrapper'
 
  Instagram.configure do |config|
    config.client_id = ENV['INSTRAGRAM_CLIENT_ID']
    config.client_secret = ENV['INSTAGRAM_CLIENT_SECRET']
  end

  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  

  def makes_magic(keyword)

    @social_array = Array.new()

    facebook_array = get_facebook(keyword)
    instagram_array = get_instagram(keyword)
    twitter_array = get_twitter(keyword)
    soundcloud_array = get_soundcloud(keyword)
    google_news_array = get_news(keyword)
    youtube_array = get_youtube(keyword)

    @social_array.push(facebook_array)
    @social_array.push(instagram_array)
    @social_array.push(twitter_array)
    @social_array.push(soundcloud_array)
    @social_array.push(google_news_array)
    @social_array.push(youtube_array)

    @social_array

  end



  def get_twitter(keyword)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    tweets_array = Array.new
    search = client.search("##{keyword}", :result_type => "popular", :count => 1)
    search.each do |element|
      tweets_array.push(TwitterWrapper.new(element))
    end
    tweets_array
  end

  def get_soundcloud(keyword)
    require 'soundcloud'
    client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])
    
    tracks_array = Array.new
    tracks = client.get('/tracks', :q => "#{keyword}", :licence => 'cc-by-sa', :limit => 1)
    tracks.each do |element|
      embed = client.get('/oembed', :url => element.uri, :show_comments => false, :maxheight => 200).html
      tracks_array.push(SoundCloudWrapper.new(element, embed))
    end
    tracks_array
  end

  def get_youtube(keyword)
    you_tube_array = Array.new
    uri = "https://gdata.youtube.com/feeds/api/videos?q=#{keyword}&orderby=published&alt=json"
    rest_resource = RestClient::Resource.new(uri)
    users = rest_resource.get
    videos = JSON.parse(users)

    entry = videos["feed"]["entry"]
      entry.each do |element|
      you_tube_array.push(YouTube.new(element))
    end
    you_tube_array
  end

  def get_news(keyword)
    news_array = Array.new
    uri = "https://ajax.googleapis.com/ajax/services/search/news?v=1.0&q=#{keyword}"
    rest_resource = RestClient::Resource.new(uri)
    users = rest_resource.get
    news = JSON.parse(users)

    entry = news["responseData"]["results"]
    entry.each do |element|
        news_array.push(News.new(element))
    end
    news_array
  end

  def get_mood()
    t = Textalytics::Client.new(sentiment: "969ea3102d79b9a99d4869728e439b62", classification: "969ea3102d79b9a99d4869728e439b62")
    movie_sentiment = t.sentiment(txt: 'The movie was terrible, never see a movie of that director. Even the actors are bad.', model: 'en-general')

  end
  def get_language(keyword)
    translator = BingTranslator.new('global_hackathon', 'iBUAYiP/ycj3WeEeDiz35nX8Ns9x/OXQJCKWXOt3UAc=')
    locale = translator.detect "#{keyword}"
  end

  def get_instagram(keyword)

    instagram_array = Array.new()

    client = Instagram.client(:access_token => ENV['INSTAGRAM_ACCESS_TOKEN'])
    tags = client.tag_search(keyword)

    if !tags.blank? 
      for media_item in client.tag_recent_media(tags[0].name)
        instagram_array.push(InstagramWrapper.new(media_item))
      end
    end
    instagram_array
  end

  def get_facebook(keyword)
    facebook_array = Array.new  
    Koala.config.api_version = "v1.0"
    oauth_access_token = ENV['FACEBOOK_ACCESS_TOKEN']
    @graph = Koala::Facebook::API.new(oauth_access_token)
    @post  = @graph.get_object("/search?type=post&q=%23#{keyword}&fields=caption,message,from,picture", {}, api_version: "v1.0")

    @post.each do |element|
      facebook_array.push(FacebookWrapper.new(element))
    end
    facebook_array
  end
end
