class Recommendation < ActiveRecord::Base
  belongs_to :recommender, class_name: 'User', foreign_key: 'recommender_id'
  belongs_to :recommendee, class_name: 'User', foreign_key: 'recommendee_id'
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
  validates :recommender,
    presence: true
  validates :recommendee,
    presence: true

  private

  def create_movie
    if !Movie.find_by(rottentomatoes_id: self.rottentomatoes_id)
      movie = MovieFinder.new.find_movie(self.rottentomatoes_id)
      movie.save
    end
  end
end
