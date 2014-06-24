class UsersController < ApplicationController
  before_action :set_user, except: [:search]
  before_action :authenticate_user!

  def show
    friendships = Friendship.where(user: current_user, friend: @user)
    if friendships.length == 1
      @currently_friends = true
      @pending = friendships[0].pending
    else
      @currently_friends = false
      @pending = false
    end
  end

  def friend
    if current_user == @user
      flash[:notice] = 'You cannot friend yourself.'
      redirect_to user_path and return
    end

    users_friends = Friendship.where(user: @user, friend: current_user)
    current_users_friends = Friendship.where(user: current_user, friend: @user)

    if users_friends.length == 0 && current_users_friends.length == 0
      # create a pending friendship
      Friendship.create(user: @user, friend: current_user, pending: true)
      flash[:notice] = 'Friend request sent.'
    elsif users_friends.length == 1 && current_users_friends.length == 0
      # already friended, do nothing
      flash[:notice] = 'Friend request sent.'
    elsif users_friends.length == 0 && current_users_friends.length == 1
      # pending friendship exists
      pending_friendship = current_users_friends[0]
      pending_friendship.pending = false
      pending_friendship.save

      new_friendship = Friendship.new(user: @user, friend: current_user, pending: false)
      new_friendship.save
      flash[:notice] = 'User successfully friended.'
    else
      # already friends, do nothing
    end

    redirect_to user_path(@user)
  end

  def unfriend
    Friendship.where(user: @user, friend: current_user).destroy_all
    Friendship.where(user: current_user, friend: @user).destroy_all

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
