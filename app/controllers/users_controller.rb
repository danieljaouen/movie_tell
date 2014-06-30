class UsersController < ApplicationController
  before_action :set_user, except: [:search]
  before_action :authenticate_user!

  def show
  end

  def friend
    if current_user == @user
      flash[:alert] = 'You cannot friend yourself.'
      redirect_to user_path and return
    end

    if current_user.friend_request_received_from?(@user)
      current_user.accept_friend_request_from(@user)
      flash[:notice] = 'User successfully friended.'
    elsif !current_user.currently_friends_with?(@user) && !current_user.friend_request_sent_to?(@user)
      current_user.send_friend_request_to(@user)
      flash[:notice] = 'Friend request sent.'
    else
      flash[:notice] = 'Friend request sent.'
    end

    redirect_to user_path(@user)
  end

  def unfriend
    current_user.unfriend(@user)

    flash[:alert] = 'User successfully unfriended.'
    redirect_to user_path(@user)
  end

  def search
    email = request.GET[:email]
    @user = User.find_by(email: email)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
