require 'httparty'

class MoviesController < ApplicationController
  before_action :authenticate_user!

  def show
    users = User.where(id: current_user.id).includes(:friends)
    @user = users[0]

    @movie = MovieFinder.new.find_movie(params[:id])
    @rating = (
      current_user.ratings.find_by(rottentomatoes_id: params[:id]) ||
      Rating.new(rottentomatoes_id: params[:id], rater: current_user)
    )
  end

  def search
    if request.GET[:title]
      @movie_dicts = MovieFinder.new.search(request.GET[:title])
    else
      @movie_dicts = []
    end
  end
end
