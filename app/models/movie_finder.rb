require 'httparty'

class MovieFinder
  def initialize
    @api_key = Rails.application.secrets.rottentomatoes_api_key
  end

  def find_movie(id)
    movie_base_url = 'http://api.rottentomatoes.com/api/public/v1.0/movies/'
    movie_url      = movie_base_url + id.to_s + ".json?apikey=#{@api_key}"

    response = HTTParty.get(movie_url)
    movie_dict = JSON.parse(response.body, symbolize_names: true)
    Movie.find_by(rottentomatoes_id: id) || Movie.new(
      rottentomatoes_id: movie_dict[:id],
      title: movie_dict[:title],
      year: movie_dict[:year],
      mpaa_rating: movie_dict[:mpaa_rating],
      critics_score: movie_dict[:ratings][:critics_score],
      audience_score: movie_dict[:ratings][:audience_score]
    )
  end

  def search(title)
    encoded_title   = URI.encode(title)
    search_base_url = 'http://api.rottentomatoes.com/api/public/v1.0/movies.json'
    search_url      = search_base_url + "?apikey=#{@api_key}&q=#{encoded_title}&page_limit=10&page=1"
    response        = HTTParty.get(search_url)
    response_dict   = JSON.parse(response.body, symbolize_names: true)

    response_dict[:movies]
  end
end
