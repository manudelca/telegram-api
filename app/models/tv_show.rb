require_relative '../presentation/tv_show_output_parser'
require_relative 'content'

class TvShow < Content
  attr_reader :name, :audience, :duration_minutes,
              :genre, :country, :director,
              :first_actor, :second_actor
  attr_accessor :id, :episodes

  def initialize(name, audience, duration_minutes,
                 genre, country, director,
                 first_actor, second_actor = nil, id = nil,
                 output_parser = TvShowOutputParser.new)
    super(id)
    @name = name
    @audience = audience
    @duration_minutes = duration_minutes
    @genre = genre
    @country = country
    @director = director
    @first_actor = first_actor
    @second_actor = second_actor
    @episodes = []
    @output_parser = output_parser
  end

  def full_details(episode)
    @output_parser.full_json(self, episode)
  end

  def details
    @output_parser.details_json(self)
  end

  def number_of_seasons
    episodes.uniq(&:season_number).size
  end

  def number_of_episodes
    episodes.size
  end

  def is_viewable
    false
  end

  def can_be_a_release
    false
  end
end
