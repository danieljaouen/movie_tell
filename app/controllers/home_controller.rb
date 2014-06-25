class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    users = User.where(id: current_user.id).includes(:friendships, :ratings, :recommendations, :recommended)
    @user = users[0]
  end
end
