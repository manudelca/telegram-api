class EpisodeOutputParser
  def seen_json(episode)
    {
      id: episode.id,
      name: episode.name,
      genre: episode.genre.name,
      director: episode.director,
      first_actor: episode.first_actor,
      second_actor: episode.second_actor
    }
  end
end
