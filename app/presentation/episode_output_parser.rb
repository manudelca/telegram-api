class EpisodeOutputParser
  def seen_json(episode)
    {
      id: episode.id,
      name: episode.tv_show.name,
      genre: episode.tv_show.genre.name,
      director: episode.tv_show.director,
      first_actor: episode.tv_show.first_actor,
      second_actor: episode.tv_show.second_actor,
      season_number: episode.season_number
    }
  end

  def release_json(episode)
    tv_show = episode.tv_show
    {
      id: tv_show.id,
      name: tv_show.name,
      genre: tv_show.genre.name,
      director: tv_show.director,
      first_actor: tv_show.first_actor,
      second_actor: tv_show.second_actor,
      season_number: episode.season_number,
      release_date: episode.release_date
    }
  end
end
