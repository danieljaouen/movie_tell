class RecommendationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recommendation, only: [:destroy]

  def create
    rottentomatoes_id = params[:rottentomatoes_id]

    friends = extract_friends
    friends.each do |friend|
      recommendation = Recommendation.new(rottentomatoes_id: rottentomatoes_id,
                                          recommender: current_user,
                                          recommendee: friend)
      recommendation.save
    end

    redirect_to movie_path(id: rottentomatoes_id),
      notice: 'Recommendation was successfully created.'
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

  def extract_friends
    friends = []
    params.each do |key, val|
      next if !key.to_s.start_with? 'friend-'

      friend = User.find_by(id: val.to_i)
      friends << friend if current_user.friends.include?(friend)
    end

    friends
  end
end
