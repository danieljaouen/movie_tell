class MoviesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.includes(:friends).find(current_user.id)

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
