class TvShowOutputParser
  def full_json(tv_show, episode)
    {
      id: episode.id,
      tv_show_id: tv_show.id,
      name: tv_show.name,
      audience: tv_show.audience,
      duration_minutes: tv_show.duration_minutes,
      genre: tv_show.genre.name,
      country: tv_show.country,
      director: tv_show.director,
      release_date: episode.release_date,
      first_actor: tv_show.first_actor,
      second_actor: tv_show.second_actor,
      season_number: episode.season_number,
      episode_number: episode.number
    }
  end

  def details_json(tv_show)
    {
      id: tv_show.id,
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

  def standard_suggestion_json(tv_show)
    {
      id: tv_show.id,
      name: tv_show.name,
      genre: tv_show.genre.name,
      director: tv_show.director,
      first_actor: tv_show.first_actor,
      second_actor: tv_show.second_actor,
      seasons: tv_show.number_of_seasons,
      episodes: tv_show.number_of_episodes
    }
  end

  def weather_suggestion_json(tv_show)
    standard_suggestion_json(tv_show)
  end
end
