class KiinosController < ApplicationController
  require 'Facebook'

  def index

    @facebookArray = Array.new  

    Koala.config.api_version = "v1.0"
    oauth_access_token = "CAACEdEose0cBALHDT2xmwyF5Wo8Hq1td0BGN3PNsyl01iljdaMzZAhurpowq1XerrVEmOILipY2r8QZAvKyPJPYzRJbydnxS0H7B4sZBw3xtQzr3o3jvFkxuvhG4ZBPXouker9ZB6pOZAZA5lZCfUEZB5TcoQxsi5QlAsDZA4MD3J9rSNn9ZBIx2IWXSRjHpy6zHleiRmJBxU0L9ZBY4psEZC5xab"
    @graph = Koala::Facebook::API.new(oauth_access_token)
    # profile = @graph.get_object("me")

    # https://graph.facebook.com/search?type=post&q=%23food
    @post  = @graph.get_object("/search?type=post&q=%23food&fields=caption,message,from,picture", {}, api_version: "v1.0")

    @post.each do |element|
      @facebookArray.push(Facebook.new(element))
    end

    # binding.pry
  end
end
