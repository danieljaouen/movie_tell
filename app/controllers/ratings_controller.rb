class RatingsController < ApplicationController
  before_action :set_rating, only: [:update, :destroy]
  before_action :authenticate_user!

  def create
    @rating = Rating.new(rating_params)
    @rating.rater = current_user

    if @rating.save
      redirect_to movie_path(id: @rating.rottentomatoes_id),
        notice: 'Rating was successfully created.'
    else
      redirect_to movie_path(id: @rating.rottentomatoes_id),
        alert: 'Please select a rating.'
    end
  end

  def update
    if @rating.update(rating_params)
      redirect_to movie_path(id: @rating.rottentomatoes_id),
        notice: 'Rating was successfully updated.'
    else
      redirect_to movie_path(id: @rating.rottentomatoes_id),
        alert: 'Please select a rating.'
    end
  end

  def destroy
    @rating.destroy
    redirect_to root_path,
      notice: 'Rating was successfully destroyed.'
  end

  private

  def set_rating
    @rating = current_user.ratings.find(params[:id])
  end

  def rating_params
    params.require(:rating).permit(:rottentomatoes_id, :rating)
  end
end
