class RecommendationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recommendation, only: [:destroy]

  def create
    rottentomatoes_id = params[:rottentomatoes_id]
    friends = []
    params.each do |key, val|
      if key.to_s.start_with? 'friend-'
        friend = User.find_by(id: val.to_i)
        friends << friend
      end
    end
    friends = friends.reject(&:nil?)
    friends.each do |friend|
      recommendation = Recommendation.new(rottentomatoes_id: rottentomatoes_id,
                                          recommender: current_user,
                                          recommendee: friend)
      recommendation.save
    end

    respond_to do |format|
      format.html do
        redirect_to movie_path(id: rottentomatoes_id),
          notice: 'Recommendation was successfully created.'
      end
    end
  end

  def destroy
    @recommendation.destroy
    redirect_to root_path,
      notice: 'Recommendation was successfully destroyed.'
  end

  private

  def set_recommendation
    @recommendation = Recommendation.find(params[:id])
  end

  def recommendation_params
    params.permit(:rottentomatoes_id, :recommendee_id)
  end
end
