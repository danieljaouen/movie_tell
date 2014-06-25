class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = (
      User.includes(
        :ratings,
        recommendations: [:movie],
        recommended: [:movie],
        friendships: [:friend]
      ).find(current_user.id)
    )
  end
end
