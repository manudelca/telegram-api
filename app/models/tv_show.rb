class TvShow
  attr_reader :name, :audience, :duration_minutes,
              :genre, :country, :director,
              :release_date, :first_actor,
              :second_actor, :seasons
  attr_accessor :id

  def initialize(name, audience, duration_minutes,
                 genre, country, director,
                 release_date, first_actor,
                 second_actor = nil, id = nil, seasons = [])
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
    @seasons = seasons
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

  def type_of_content
    'tv_show'
  end
end
