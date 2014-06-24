class RatingsController < ApplicationController
  before_action :set_rating, only: [:update, :destroy]
  before_action :authenticate_user!

  def create
    @rating = Rating.new(rating_params)
    @rating.rater = current_user

    respond_to do |format|
      if @rating.save
        format.html do
          redirect_to movie_path(id: @rating.rottentomatoes_id),
            notice: 'Rating was successfully created.'
        end
      else
        format.html do
          redirect_to movie_path(id: @rating.rottentomatoes_id),
            alert: 'Please select a rating.'
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html do
          redirect_to movie_path(id: @rating.rottentomatoes_id),
            notice: 'Rating was successfully updated.'
        end
      else
        format.html do
          redirect_to movie_path(id: @rating.rottentomatoes_id),
            alert: 'Please select a rating.'
        end
      end
    end
  end

  def destroy
    @rating.destroy
    respond_to do |format|
      format.html do
        redirect_to movie_path,
          notice: 'Rating was successfully destroyed.'
      end
    end
  end

  private

  def set_rating
    @rating = Rating.find(params[:id])
  end

  def rating_params
    params.require(:rating).permit(:rottentomatoes_id, :rating)
  end
end
