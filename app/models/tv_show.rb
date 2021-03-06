require_relative '../presentation/tv_show_output_parser'
require_relative 'full_content'

class TvShow < FullContent
  attr_reader :name, :audience, :duration_minutes,
              :country, :director, :first_actor, :second_actor
  attr_accessor :id, :episodes, :genre

  def self.create_tv_show_with_episode(name, audience, duration_minutes,
                                       genre, country, director,
                                       first_actor, second_actor = nil,
                                       episode_number, season_number,
                                       release_date, tv_show_repo, episode_repo)
    saved_tv_show = tv_show_repo.find_by_name(name)
    unless saved_tv_show.nil?
      saved_episode = episode_repo.find_by_tv_show_id_number_season_and_release_date(saved_tv_show.id,
                                                                                     episode_number,
                                                                                     season_number,
                                                                                     release_date)
      raise ContentAlreadyCreated unless saved_episode.nil?
    end

    tv_show = TvShow.new(name,
                         audience,
                         duration_minutes,
                         genre,
                         country,
                         director,
                         first_actor,
                         second_actor)

    episode = Episode.new(episode_number,
                          season_number,
                          release_date)

    tv_show.episodes << episode
    tv_show
  end

  def initialize(name, audience, duration_minutes,
                 genre, country, director,
                 first_actor, second_actor = nil, id = nil,
                 output_parser = TvShowOutputParser.new)
    super(genre, id)
    raise MissingNameError if name.nil?

    @name = name
    @audience = audience
    @duration_minutes = duration_minutes
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

  def is_listable
    true
  end

  def can_be_a_release
    false
  end

  def can_be_a_weather_suggestion
    true
  end

  def as_weather_suggestion
    @output_parser.weather_suggestion_json(self)
  end

  def be_liked_by(client)
    likes = 0
    @episodes.each do |episode|
      likes += 1 if client.liked_content?(episode)
    end
    raise NotEnoughEpisodesLikedError if likes < 3

    client.add_liked_content(self)
  end
end
