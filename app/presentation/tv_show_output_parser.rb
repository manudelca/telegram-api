class TvShowOutputParser
  def full_json(tv_show, season, episode) # rubocop:disable Metrics/AbcSize
    {
      id: IdConverter.new.parse_episode_id(episode.id),
      tv_show_id: IdConverter.new.parse_tv_show_id(tv_show.id),
      name: tv_show.name,
      audience: tv_show.audience,
      duration_minutes: tv_show.duration_minutes,
      genre: tv_show.genre.name,
      country: tv_show.country,
      director: tv_show.director,
      release_date: tv_show.release_date,
      first_actor: tv_show.first_actor,
      second_actor: tv_show.second_actor,
      season_number: season.number,
      episode_number: episode.number
    }
  end

  def details_json(tv_show)
    {
      id: IdConverter.new.parse_tv_show_id(tv_show.id),
      name: tv_show.name,
      audience: tv_show.audience,
      duration_minutes: tv_show.duration_minutes,
      genre: tv_show.genre.name,
      country: tv_show.country,
      director: tv_show.director,
      first_actor: tv_show.first_actor,
      second_actor: tv_show.second_actor,
      seasons: tv_show.number_of_seasons,
      episodes: tv_show.number_of_episodes
    }
  end

  def release_json(tv_show)
    last_season = tv_show.last_season
    {
      id: IdConverter.new.parse_tv_show_id(tv_show.id),
      name: tv_show.name,
      genre: tv_show.genre.name,
      director: tv_show.director,
      first_actor: tv_show.first_actor,
      second_actor: tv_show.second_actor,
      season_number: last_season.number,
      release_date: tv_show.release_date
    }
  end
end
