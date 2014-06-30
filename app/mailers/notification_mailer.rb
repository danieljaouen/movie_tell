class NotificationMailer < ActionMailer::Base
  default from: 'noreply@movie-tell.com'

  def new_user(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Movie Tell!')
  end

  def new_friend_request(user)
    @user = user
    mail(to: @user.email, subject: '[Movie Tell] New Friend Request!')
  end

  def new_recommendation(user)
    @user = user
    mail(to: @user.email, subject: '[Movie Tell] New Recommendation!')
  end
end
