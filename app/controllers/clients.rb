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

  # /clients/client_id/contents/content_id/seen

  patch :update, :map => '/clients/:email/contents/:content_id/seen' do
    begin
      client = client_repo.find_by_email(params[:email])
      raise ClientNotFound if client.nil?

      # asi deberia quedar
      # client = client_repo.find_by_email(client_params[:email])
      # raise ClientNotFound if client.nil?
      # content = content_repo.find_by_id(client_params[:content_id])
      # client.sees_content(content, @@date, client_repo)

      content = find_content(params[:content_id])
      client.sees_content(content, @@date, client_repo)
      client_repo.update_contents_seen(client)
      status 201
      {
        :message => 'Visto registrado exitosamente'
      }.to_json
    rescue ContentNotFound, RepoNotFound, NotViewableContentError
      status 404
      {
        :message => "Error: el contenido con id #{params[:content_id]} no se encuentra registrada"
      }.to_json
    rescue ClientNotFound
      status 404
      {
        :message => "Error: el usuario con email #{params[:email]} no se encuentra registrado"
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
end
