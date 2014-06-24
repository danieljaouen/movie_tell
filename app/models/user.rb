class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :ratings

  has_many :recommendations, class_name: 'Recommendation', foreign_key: 'recommender_id'
  has_many :recommended, class_name: 'Recommendation', foreign_key: 'recommendee_id'
end
