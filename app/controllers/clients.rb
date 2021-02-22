WebTemplate::App.controllers :clients do
  post :create, :map => '/register' do
    begin
      client = Client.new(client_params[:email], client_params[:telegram_user_id])
      client_with_same_email = client_repo.find_by_email(client_params[:email])
      raise EmailRepeatedError unless client_with_same_email.nil?

      client_repo.create_client(client)
      status 201
      {
        :message => 'Bienvenido! :)'
      }.to_json
    rescue NoEmailError
      status 404
      {
        :message => 'Error: falta el campo email'
      }.to_json
    rescue InvalidEmailError
      status 404
      {
        :message => 'Error: email inválido, ingrese un mail válido. Ej: mail@dominio.com'
      }.to_json
    rescue EmailRepeatedError
      status 404
      {
        :message => 'Error: este email ya se encuentra registrado'
      }.to_json
    end
  end

  patch :update, :map => '/clients/movies_seen' do
    begin
      client = client_repo.find_by_email(client_params[:email])
      raise ClientNotFound if client.nil?

      movie = find_content(client_params[:movie_id])
      client.sees_movie(movie, Time.now)
      client_repo.update_movies_seen(client)
      status 201
      {
        :message => 'Visto registrado exitosamente'
      }.to_json
    rescue ContentNotFound, RepoNotFound
      status 404
      {
        :message => "Error: la pelicula con id #{client_params[:movie_id]} no se encuentra registrada"
      }.to_json
    rescue ClientNotFound
      status 404
      {
        :message => "Error: el usuario con email #{client_params[:email]} no se encuentra registrado"
      }.to_json
    end
  end

  patch :update, :map => '/clients/episodes_seen' do
    begin
      client = client_repo.find_by_email(client_params[:email])
      raise ClientNotFound if client.nil?

      episode = episodes_repo.find(client_params[:episode_id])
      client.sees_episode(episode)
      client_repo.update_episodes_seen(episode)
      status 201
      {
        :message => 'Visto registrado exitosamente'
      }.to_json
    rescue ContentNotFound
      status 404
      {
        :message => "Error: el episodio con id #{client_params[:movie_id]} no se encuentra registrada"
      }.to_json
    rescue ClientNotFound
      status 404
      {
        :message => "Error: el usuario con email #{client_params[:email]} no se encuentra registrado"
      }.to_json
    end
  end

  post :update, :map => '/like' do
    begin
      client = client_repo.find_by_telegram_user_id(client_params[:telegram_user_id])
      content = find_content(client_params[:content_id])
      client.likes(content)
      client_repo.update_contents_liked(client)

      status 201
      {
        :message => 'Calificación registrada'
      }.to_json
    rescue ContentNotFound, RepoNotFound
      status 404
      {
        :message => "Error: El contenido con id #{client_params[:content_id]} no se encuentra registrada"
      }.to_json
    rescue ClientNotFound
      status 404
      {
        :message => "Error: el usuario con id #{client_params[:telegram_user_id]} no se encuentra registrado"
      }.to_json
    end
  end

  post :show, :map => '/seen_this_week' do
    begin
      client = client_repo.find_by_telegram_user_id(client_params[:telegram_user_id])
      contents = client.seen_this_week(@@now)
      seen_this_week = []
      contents.each do |content|
        seen_this_week << content.as_seen
      end

      status 201
      {
        :message => 'Búsqueda de contenido visto esta semana exitosa',
        :conetnt => seen_this_week
      }.to_json
    rescue ClientNotFound
      status 404
      {
        :message => "Error: el usuario con id #{client_params[:telegram_user_id]} no se encuentra registrado"
      }.to_json
    end
  end
end
