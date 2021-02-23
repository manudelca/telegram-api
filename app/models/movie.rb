require_relative '../presentation/movie_output_parser'

class Movie
  attr_reader :name, :audience, :duration_minutes,
              :genre, :country, :director,
              :release_date, :first_actor,
              :second_actor
  attr_accessor :id

  def initialize(name, audience, duration_minutes,
                 genre, country, director,
                 release_date, first_actor, second_actor = nil,
                 id = nil, output_parser = MovieOutputParser.new)
    @name = name
    @audience = audience
    @duration_minutes = duration_minutes
    @genre = genre
    @country = country
    @director = director
    @release_date = release_date
    @first_actor = first_actor
    @second_actor = second_actor
    @id = id
    @output_parser = output_parser
  end

  def full_details
    @output_parser.full_json(self)
  end

  def details
    @output_parser.details_json(self)
  end

  def as_release
    @output_parser.release_json(self)
  end

  def be_liked_by(client)
    client.likes_movie(self)
  end
end
