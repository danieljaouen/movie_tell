class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :ratings, foreign_key: :rater_id

  has_many :recommendations, class_name: 'Recommendation', foreign_key: 'recommendee_id'
  has_many :recommended, class_name: 'Recommendation', foreign_key: 'recommender_id'

  def current_friendships
    friendships.where(pending: false)
  end

  def pending_friendships
    friendships.where(pending: true)
  end
end
