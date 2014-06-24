require 'httparty'

class MoviesController < ApplicationController
  before_action :authenticate_user!

  def show
    movie_url = 'http://api.rottentomatoes.com/api/public/v1.0/movies/'
    api_key    = Rails.application.secrets.rottentomatoes_api_key

    url = movie_url + params[:id].to_s + ".json?apikey=#{api_key}"
    movie_response = HTTParty.get(url)
    @movie_dict = JSON.parse(movie_response.body, symbolize_names: true)
    @rating = (
      Rating.find_by(rottentomatoes_id: params[:id], rater: current_user) ||
      Rating.new(rottentomatoes_id: params[:id], rater: current_user)
    )
    @friends = current_user.friends
  end

  def search
    search_url = 'http://api.rottentomatoes.com/api/public/v1.0/movies.json'
    api_key    = Rails.application.secrets.rottentomatoes_api_key

    if request.GET[:title]
      title = URI.encode(request.GET[:title])
      url = search_url + "?apikey=#{api_key}&q=#{title}&page_limit=10&page=1"
      rottentomatoes_response = HTTParty.get(url)
      response_dict = JSON.parse(rottentomatoes_response.body, symbolize_names: true)
      @movie_dicts = response_dict[:movies]
    else
      @movie_dicts = []
    end
  end
end
