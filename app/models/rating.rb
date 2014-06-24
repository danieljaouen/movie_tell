require 'httparty'

class Rating < ActiveRecord::Base
  belongs_to :rater, class_name: 'User'
  belongs_to :movie,
    class_name: 'Movie',
    foreign_key: :rottentomatoes_id,
    primary_key: :rottentomatoes_id
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
      movie_url = 'http://api.rottentomatoes.com/api/public/v1.0/movies/'
      api_key    = Rails.application.secrets.rottentomatoes_api_key
      url = movie_url + self.rottentomatoes_id.to_s + ".json?apikey=#{api_key}"
      movie_response = HTTParty.get(url)
      @movie_dict = JSON.parse(movie_response.body, symbolize_names: true)
      @movie = Movie.new(rottentomatoes_id: @movie_dict[:id],
                         title: @movie_dict[:title],
                         year: @movie_dict[:year],
                         mpaa_rating: @movie_dict[:mpaa_rating],
                         critics_score: @movie_dict[:ratings][:critics_score],
                         audience_score: @movie_dict[:ratings][:audience_score])
      @movie.save
    end
  end
end
