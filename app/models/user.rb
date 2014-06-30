class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable

  has_one  :user_profile

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :ratings, foreign_key: :rater_id

  has_many :recommendations, class_name: 'Recommendation', foreign_key: 'recommendee_id'
  has_many :recommended, class_name: 'Recommendation', foreign_key: 'recommender_id'

  delegate :name, :private, :show_ratings,
    to: :user_profile,
    prefix: true

  before_create :send_email

  def currently_friends_with?(user)
    Friendship.where(user: self, friend: user, pending: false).length > 0
  end

  def friend_request_sent_to?(user)
    Friendship.where(user: user, friend: self, pending: true).length > 0
  end

  def friend_request_received_from?(user)
    Friendship.where(user: self, friend: user, pending: true).length > 0
  end

  def send_friend_request_to(user)
    Friendship.create(user: user, friend: self, pending: true)
  end

  def accept_friend_request_from(user)
    friendships = Friendship.where(user: self, friend: user, pending: true)
    return if friendships.length == 0

    my_friendship = friendships[0]
    my_friendship.pending = false
    my_friendship.save

    their_friendship = Friendship.create(user: user, friend: self, pending: false)
    their_friendship.save
  end

  def unfriend(user)
    Friendship.where(user: user, friend: self).destroy_all
    Friendship.where(user: self, friend: user).destroy_all
  end

  private

  def send_email
    NotificationMailer.new_user(self).deliver
  end
end
