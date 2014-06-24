class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @friendships = @user.friendships.where(pending: false)
    @pending_friendships = @user.friendships.where(pending: true)
    @ratings = Rating.where(rater: @user)
    @recommendations = Recommendation.where(recommendee: @user)
    @recommended = Recommendation.where(recommender: @user)
  end
end
