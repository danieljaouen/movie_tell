class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :ratings

  has_many :recommendations, class_name: 'Recommendation', foreign_key: 'recommender_id'
  has_many :recommended, class_name: 'Recommendation', foreign_key: 'recommendee_id'

  def current_friendships
    friendships.where(pending: false)
  end

  def pending_friendships
    friendships.where(pending: true)
  end

  def ratings
    Rating.where(rater: self)
  end

  def recommendations
    Recommendation.where(recommendee: self)
  end

  def recommended
    Recommendation.where(recommender: self)
  end
end
