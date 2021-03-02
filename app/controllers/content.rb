WebTemplate::App.controllers :content, :provides => [:json] do
  post :create, :map => '/content' do # rubocop:disable Metrics/BlockLength
    movies = []
    tv_shows = []

    content_params[:content].each do |content| # rubocop:disable Metrics/BlockLength
      genre = genre_repo.find_by_genre_name(content['genre'])
      case content['type']
      when 'movie'
        movie = Movie.new(content['name'],
                          content['audience'],
                          content['duration_minutes'],
                          genre,
                          content['country'],
                          content['director'],
                          content['release_date'],
                          content['first_actor'],
                          content['second_actor'])
        movies << movie
      when 'tv_show'
        tv_show = TvShow.new(content['name'],
                             content['audience'],
                             content['duration_minutes'],
                             genre,
                             content['country'],
                             content['director'],
                             content['first_actor'],
                             content['second_actor'])

        episode = Episode.new(content['episode_number'],
                              content['season_number'],
                              content['release_date'])
        tv_show.episodes << episode
        tv_shows << tv_show
      end
    end

    content_created = []
    movies.each do |movie|
      new_movie = movie_repo.create_content(movie)
      content_created << new_movie.full_details
    end
    tv_shows.each do |tv_show|
      new_tv_show = tv_show_repo.find_or_create(tv_show)
      episode = tv_show.episodes.first
      episode.tv_show = new_tv_show
      new_episode = episodes_repo.create_episode(episode)
      content_created << new_tv_show.full_details(new_episode)
    end

    status 201
    {
      :message => 'El contenido fue registrado exitosamente!',
      :content => content_created
    }.to_json
  end

  get :show, :map => '/content', :with => :id do
    content_id = params[:id]
    begin
      content = content_repo.find(content_id)
      raise ContentNotFound if content.nil?

      status 200
      {
        :message => 'El contenido fue encontrado!',
        :content => content.details
      }.to_json
    rescue ContentNotFound, RepoNotFound => _e
      status 404
      {
        :message => 'Error: id no se encuentra en la coleccion'
      }.to_json
    end
  end

  get :show, :map => '/releases' do
    begin
      releases = Content.releases(content_repo, @@date_provider.now)
      raise ContentNotFound if releases.empty?

      releases_formatted = []
      releases.each do |release|
        releases_formatted << release.as_release
      end

      status 200
      {
        :message => 'El contenido fue encontrado exitosamente!',
        :content => releases_formatted
      }.to_json
    rescue ContentNotFound
      status 404
      {
        :message => 'No se encontro contenido!'
      }.to_json
    end
  end

  get :show, :map => 'weather_suggestion' do
    begin
      weather_suggestions = Content.weather_suggestions(content_repo, @@weather.current_weather, @@date_provider.now)
      raise ContentNotFound if weather_suggestions.empty?

      weather_suggestions_formatted = []
      weather_suggestions.each do |weather_suggestion|
        weather_suggestions_formatted << weather_suggestion.as_weather_suggestion
      end
      status 200
      {
        :message => 'El contenido fue encontrado exitosamente!',
        :content => weather_suggestions_formatted
      }.to_json
    rescue ContentNotFound
      status 404
      {
        :message => 'No se encontro contenido!'
      }.to_json
    end
  end
end
