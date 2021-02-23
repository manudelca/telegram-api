require_relative '../presentation/tv_show_output_parser'
require_relative 'content'

class TvShow < Content
  attr_reader :name, :audience, :duration_minutes,
              :genre, :country, :director,
              :release_date, :first_actor,
              :second_actor, :seasons
  attr_accessor :id

  def initialize(name, audience, duration_minutes,
                 genre, country, director,
                 release_date, first_actor,
                 second_actor = nil, id = nil,
                 seasons = [], output_parser = TvShowOutputParser.new)
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
    @seasons = seasons
    @output_parser = output_parser
  end

  def full_details(season, episode)
    @output_parser.full_json(self, season, episode)
  end

  def details
    @output_parser.details_json(self)
  end

  def as_release
    @output_parser.release_json(self)
  end

  def number_of_seasons
    seasons.size
  end

  def number_of_episodes
    n_episodes = 0
    seasons.each do |season|
      n_episodes += season.number_of_episodes
    end
    n_episodes
  end

  def last_season
    seasons.select { |season| season.release_date == release_date }.first
  end

  def is_viewable
    false
  end
end
