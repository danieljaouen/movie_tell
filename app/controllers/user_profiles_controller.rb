class UserProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_profile, only: [:edit, :update, :destroy]

  def edit
    @user_profile ||= UserProfile.new(user: current_user)
  end

  def create
    @user_profile = UserProfile.new(user_profile_params)
    @user_profile.user = current_user

    if @user_profile.save
      redirect_to users_edit_profile_path(current_user),
        notice: 'User profile was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user_profile.update(user_profile_params)
      redirect_to users_edit_profile_path(current_user),
        notice: 'User profile was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user_profile.destroy
    redirect_to users_edit_profile_path(current_user),
      notice: 'User profile was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_profile
    @user_profile = current_user.user_profile
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_profile_params
    params.require(:user_profile).permit(:name, :private, :show_ratings)
  end
end
