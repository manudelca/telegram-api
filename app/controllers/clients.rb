WebTemplate::App.controllers :clients do
  post :create, :map => '/register' do
    client = Client.new(client_params[:email], client_params[:username])
    client_repo.create_client(client)

    status 201
    {
      :message => 'Bienvenido! :)'
    }.to_json
  end

  patch :update, :map => '/clients/see_movie' do
    client = client_repo.find_by_email(client_params[:email])
    movie = content_repo.find(client_params[:movie_id])
    client.sees_movie(movie)
    client_repo.update_movies_seen(client)
    status 201
    # que devuelvo?
  end
end
