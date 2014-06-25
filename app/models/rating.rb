require 'httparty'

class Rating < ActiveRecord::Base
  belongs_to :rater, class_name: 'User'
  belongs_to :movie,
    class_name: 'Movie',
    foreign_key: :rottentomatoes_id,
    primary_key: :rottentomatoes_id

  delegate :title, :year, :mpaa_rating, :critics_score, :audience_score,
    to: :movie,
    prefix: true

  before_create :create_movie

  validates :rottentomatoes_id,
    presence: true
  validates :rater,
    presence: true
  validates :rating,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 10,
    }

  private

  def create_movie
    if !Movie.find_by(rottentomatoes_id: self.rottentomatoes_id)
      movie = MovieFinder.new.find_movie(self.rottentomatoes_id)
      movie.save
    end
  end
end
