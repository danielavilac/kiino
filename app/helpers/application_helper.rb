module ApplicationHelper
    require 'time'

   def get_twitter(keyword)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    tweets_array = Array.new
    search = client.search("##{keyword}", :result_type => "popular", :count => 1)
    search.each do |tweet|
      object = {}
      object['date'] = tweet.created_at.strftime("%d %B %Y")
      object['tweet'] = tweet.text
      object['user'] = tweet.user.name
      tweets_array.push(object)
    end
    tweets_array
  end

  def get_soundcloud(keyword)
    require 'soundcloud'
    client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])
    
    tracks_array = Array.new
    tracks = client.get('/tracks', :q => "#{keyword}", :licence => 'cc-by-sa', :limit => 1)
    tracks.each do |track|
      object = {}
      object['date'] = Time.parse(track.created_at).strftime("%d %B %Y")
      object['title'] = track.title
      object['user'] = track.user.username
      object['embed_html'] = client.get('/oembed', :url => track.uri, :show_comments => false, :maxheight => 200).html
      tracks_array.push(object)
    end
    tracks_array
  end

end
