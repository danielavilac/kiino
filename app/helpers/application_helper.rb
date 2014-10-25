 module ApplicationHelper

  require 'time'
  require 'rest_client'
  require 'YouTubeWrapper'
  require 'NewsWrapper'
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

    social_array = Hash.new

    array = keyword.split(/ /)


    if (array.length == 3)

      key = ""

      if array[1] == "in" && array[2] == "instagram"
        thread1 = Thread.new{social_array['instagram']=get_instagram(array[0])}
        thread2 = Thread.new{social_array['twitter']= get_twitter(array[0])}

        thread1.join
        thread2.join

        key = 'instagram'
      elsif array[1] == "in" && array[2] == "youtube"
        thread1 = Thread.new{social_array['youtube']= get_youtube(array[0])}
        thread2 = Thread.new{social_array['twitter']= get_twitter(array[0])}

        thread1.join
        thread2.join

        key = 'youtube'
      end

      final_array = fill_map_x(social_array,key)
    else 

      thread1 = Thread.new{social_array['facebook']= get_facebook(array[0])}
      thread2 = Thread.new{social_array['twitter']=get_twitter(array[0])}
      thread3 = Thread.new{social_array['news']=get_news(array[0])}
      thread4 = Thread.new{social_array['instagram']=get_instagram(array[0])}
      thread5 = Thread.new{social_array['soundcloud']=get_soundcloud(array[0])}
      thread6 = Thread.new{social_array['youtube']=get_youtube(array[0])}

      thread1.join
      thread2.join
      thread3.join
      thread4.join
      thread5.join
      thread6.join
      final_array = fill_map(social_array)
    end

    # fill_languages(final_array)
    # fill_moods(final_array)
    final_array
  end

  def fill_languages(final_array)
    final_array.each do|final_element| 
      if final_element.nil?
        break;
      end
      language = get_language(final_element.data)
      if language != 'en'
        final_element.language = language
        final_element.data =  'sa'
      else 
        final_element.language ='en'
      end
    end 
  end

  def fill_moods(final_array)

    final_array.each do|final_element| 
      final_element.mood = get_mood(final_element.data)
    end 
  end
  

  def fill_map_x(social_array, key)
    
    final_array = Array.new

    13.times do |index|

        if (index <= 3)
          final_array.push(social_array[key][index])
        else
          final_array.push(social_array['twitter'][index-4])
        end
    end 
    final_array
    binding.pry 
  end 


  def fill_map(social_array)
    final_array = Array.new

    twitter_elements_acum = 0


    facebook_array_length = social_array['facebook'].length

    if facebook_array_length < 3
      twitter_elements_acum += 3 - facebook_array_length
      facebook_array_length.times do |index|
        final_array.push(social_array['facebook'][index])
        #social_array['facebook'].delete_at(index)
      end
    else
      3.times do |index|
        final_array.push(social_array['facebook'][index])
        #social_array['facebook'].delete_at(index)
      end 
    end


    news_array_length = social_array['news'].length

    if news_array_length < 3
      twitter_elements_acum += 3 - news_array_length
      news_array_length.times do |index|
        final_array.push(social_array['news'][index])
        #social_array['news'].delete_at(index)
      end
    else
      3.times do |index|
        final_array.push(social_array['news'][index])
        #social_array['news'].delete_at(index)
      end 
    end


    if social_array['youtube'].length < 1
      twitter_elements_acum += 1
    else 
      final_array.push(social_array['youtube'][0])
      #social_array['youtube'].delete_at(0)
    end

    if social_array['soundcloud'].length < 1
      twitter_elements_acum += 1
    else
      final_array.push(social_array['soundcloud'][0])
      #social_array['soundcloud'].delete_at(0)
    end

    if social_array['instagram'].length < 1
      twitter_elements_acum += 1
    else
      final_array.push(social_array['instagram'][0])
      #social_array['instagram'].delete_at(0)
    end

    twitter_array_length = social_array['twitter'].length

    (twitter_elements_acum + 3).times do |index|  
      final_array.push(social_array['twitter'][index])
      #social_array['twitter'].delete_at(index)
    end

    final_array.push(social_array['instagram'][1]) #

    final_array

  end

  def get_twitter(keyword)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    tweets_array = Array.new
    search = client.search("##{keyword}", :result_type => "popular", :count => 25)
    search.each do |element|
      tweets_array.push(TwitterWrapper.new(element))
    end
    tweets_array
  end

  def get_soundcloud(keyword)
    require 'soundcloud'
    client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_CLIENT_ID'])
    
    tracks_array = Array.new
    tracks = client.get('/tracks', :q => "#{keyword}", :licence => 'cc-by-sa', :limit => 3)
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
      you_tube_array.push(YouTubeWrapper.new(element))
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
        news_array.push(NewsWrapper.new(element))
    end
    news_array
  end

  def get_mood(text)
    t = Textalytics::Client.new(sentiment: "969ea3102d79b9a99d4869728e439b62", classification: "969ea3102d79b9a99d4869728e439b62")
    movie_sentiment = t.sentiment(txt: text, model: 'en-general')
    if movie_sentiment.score_tag.nil?
      "NEU"
    else
      movie_sentiment.score_tag
    end
  end

  def get_language(keyword)
    translator = BingTranslator.new('global_hackathon', 'iBUAYiP/ycj3WeEeDiz35nX8Ns9x/OXQJCKWXOt3UAc=')
    locale = translator.detect "#{keyword}"
    locale
  end

  def get_translation(keyword)
    translator = BingTranslator.new('global_hackathon', 'iBUAYiP/ycj3WeEeDiz35nX8Ns9x/OXQJCKWXOt3UAc=')
    english = translator.translate "#{keyword}", :to => 'en'
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
