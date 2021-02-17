require 'byebug'
WebTemplate::App.controllers :clients do
  post :create, :map => '/register' do
    client = Client.new(client_params[:email], client_params[:telegram_user_id])
    client_repo.create_client(client)

    status 201
    {
      :message => 'Bienvenido! :)'
    }.to_json
  end

  patch :update, :map => '/clients/movies_seen' do
    begin
      client = client_repo.find_by_email(client_params[:email])
      movie = movie_repo.find(client_params[:movie_id])
      client.sees_movie(movie)
      client_repo.update_movies_seen(client)
      status 201
      {
        :message => 'Visto registrado exitosamente'
      }.to_json
    rescue ContentNotFound
      status 404
      {
        :message => "Error: la pelicula con id #{client_params[:movie_id]} no se encuentra registrada"
      }.to_json
    rescue ClientNotFound
      status 404
      {
        :message => "Error: el usario con email #{client_params[:email]} no se encuentra registrado"
      }.to_json
    end
  end

  post :update, :map => '/like' do
    client = client_repo.find_by_telegram_user_id(client_params[:telegram_user_id])
    content = generic_content_repo.find(client_params[:content_id])
    client.likes(content)
    client_repo.update_contents_liked(client)

    status 201
    {
      :message => 'Calificación registrada'
    }.to_json
  end
end
