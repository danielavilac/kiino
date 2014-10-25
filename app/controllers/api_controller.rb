class ApiController < ApplicationController
	
	def kiino
		kiino = view_context.makes_magic(params[:keyword])
		render json: kiino
	end

	def tweets
		tweets = view_context.get_twitter(params[:keyword])
		render json: tweets
	end

	def posts
		posts = view_context.get_facebook(params[:keyword])
		render json: posts
	end

	def photos
		photos = view_context.get_instagram(params[:keyword])
		render json: photos
	end

	def news
		news = view_context.get_news(params[:keyword])
		render json: news
	end

	def videos
		videos = view_context.get_youtube(params[:keyword])
		render json: videos
	end

	def music
		music = view_context.get_soundcloud(params[:keyword])
		render json: music
	end

end
