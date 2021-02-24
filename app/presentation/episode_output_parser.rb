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
end
