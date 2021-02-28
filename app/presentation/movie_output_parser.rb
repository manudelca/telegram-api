class MovieOutputParser
  def full_json(movie)
    {
      id: movie.id,
      name: movie.name,
      audience: movie.audience,
      duration_minutes: movie.duration_minutes,
      genre: movie.genre.name,
      country: movie.country,
      director: movie.director,
      release_date: movie.release_date,
      first_actor: movie.first_actor,
      second_actor: movie.second_actor
    }
  end

  def details_json(movie)
    {
      id: movie.id,
      name: movie.name,
      audience: movie.audience,
      duration_minutes: movie.duration_minutes,
      genre: movie.genre.name,
      country: movie.country,
      director: movie.director,
      first_actor: movie.first_actor,
      second_actor: movie.second_actor
    }
  end

  def standard_suggestion_json(movie)
    {
      id: movie.id,
      name: movie.name,
      genre: movie.genre.name,
      director: movie.director,
      first_actor: movie.first_actor,
      second_actor: movie.second_actor,
      release_date: movie.release_date
    }
  end

  def release_json(movie)
    standard_suggestion_json(movie)
  end

  def weather_suggestion(movie)
    standard_suggestion_json(movie)
  end

  def seen_json(movie)
    {
      id: movie.id,
      name: movie.name,
      genre: movie.genre.name,
      director: movie.director,
      first_actor: movie.first_actor,
      second_actor: movie.second_actor
    }
  end
end
