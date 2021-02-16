WebTemplate::App.controllers :clients do
  post :create, :map => '/register' do
    client = Client.new(client_params[:email], client_params[:username])
    client_repo.create_client(client)

    status 201
    {
      :message => 'Bienvenido! :)'
    }.to_json
  end

  patch :update, :map => '/client' do
  end
end
