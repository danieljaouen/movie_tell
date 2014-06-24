class Movie < ActiveRecord::Base
  has_many :ratings, foreign_key: :rottentomatoes_id
  has_many :recommendations, foreign_key: :rottentomatoes_id

  validates :rottentomatoes_id,
    presence: true,
    uniqueness: true
  validates :title,
    presence: true
  validates :year,
    presence: true
  validates :mpaa_rating,
    presence: true
  validates :critics_score,
    presence: true
  validates :audience_score,
    presence: true
end
