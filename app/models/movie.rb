require_relative '../presentation/movie_output_parser'
require_relative 'content'

class Movie < Content
  attr_reader :name, :audience, :duration_minutes,
              :genre, :country, :director,
              :release_date, :first_actor,
              :second_actor
  attr_accessor :id

  def initialize(name, audience, duration_minutes,
                 genre, country, director,
                 release_date, first_actor, second_actor = nil,
                 id = nil, output_parser = MovieOutputParser.new)
    super(id)
    @name = name
    @audience = audience
    @duration_minutes = duration_minutes
    @genre = genre
    @country = country
    @director = director
    @release_date = release_date
    @first_actor = first_actor
    @second_actor = second_actor
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

  def as_weather_suggestion
    @output_parser.weather_suggestion_json(self)
  end

  def as_seen
    @output_parser.seen_json(self)
  end

  def is_viewable
    true
  end

  def is_listable
    true
  end

  def can_be_a_release
    true
  end

  def can_be_a_weather_suggestion
    true
  end

  def be_liked_by(client)
    client.add_liked_content(self)
  end
end
