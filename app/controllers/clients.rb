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

  patch :update, :map => '/clients/:email/contents/:content_id/seen' do # rubocop:disable Metrics/BlockLength
    begin
      client = client_repo.find_by_email(params[:email])
      raise ClientNotFound if client.nil?

      content = content_repo.find(params[:content_id])
      raise ContentNotFound if content.nil?

      client.sees_content(content, @@date_provider.now, client_repo)
      status 201
      {
        :message => 'Visto registrado exitosamente'
      }.to_json
    rescue ContentNotFound, NotViewableContentError
      status 404
      {
        :message => "Error: el contenido con id #{params[:content_id]} no se encuentra registrado"
      }.to_json
    rescue ClientNotFound
      status 404
      {
        :message => "Error: el usuario con email #{params[:email]} no se encuentra registrado"
      }.to_json
    rescue ContentNotReleasedError
      status 404
      {
        :message => 'Error: no se puede registrar como visto contenido no estrenado'
      }.to_json
    end
  end

  patch :update, :map => '/clients/:telegram_user_id/contents/:content_id/list' do
    begin
      client = client_repo.find_by_telegram_user_id(params[:telegram_user_id])
      raise ClientNotFound if client.nil?

      content = content_repo.find(params[:content_id])
      raise ContentNotFound if content.nil?

      client.lists(content, client_repo)
      status 201
      {
        :message => 'Contenido agregado a la lista exitosamente'
      }.to_json
    rescue ContentNotFound, NotListableContentError
      status 404
      {
        :message => "Error: el contenido con id #{params[:content_id]} no se encuentra registrado"
      }.to_json
    rescue ClientNotFound
      status 404
      {
        :message => 'Error: el usuario no se encuentra registrado'
      }.to_json
    end
  end

  post :update, :map => '/like' do # rubocop:disable Metrics/BlockLength
    begin
      client = client_repo.find_by_telegram_user_id(client_params[:telegram_user_id])
      content = content_repo.find(client_params[:content_id])
      raise ContentNotFound if content.nil?

      client.likes(content, client_repo)

      status 201
      {
        :message => 'Calificación registrada'
      }.to_json
    rescue ContentNotFound
      status 404
      {
        :message => "Error: El contenido con id #{client_params[:content_id]} no se encuentra registrada"
      }.to_json
    rescue ClientNotFound
      status 404
      {
        :message => "Error: el usuario con id #{client_params[:telegram_user_id]} no se encuentra registrado"
      }.to_json
    rescue ContentNotSeenError
      status 404
      {
        :message => 'Error: contenido no visto'
      }.to_json
    rescue ContentAlreadyLikedError
      status 400
      {
        :message => 'Error: contenido ya calificado'
      }.to_json
    end
  end

  post :show, :map => '/seen_this_week' do
    begin
      client = client_repo.find_by_telegram_user_id(client_params[:telegram_user_id])
      contents = client.seen_this_week(@@date_provider.now)
      raise ContentNotFound if contents.empty?

      seen_this_week = []
      contents.each do |content|
        seen_this_week << content.as_seen
      end

      status 201
      {
        :message => 'Búsqueda de contenido visto esta semana exitosa',
        :content => seen_this_week
      }.to_json
    rescue ClientNotFound
      status 404
      {
        :message => "Error: el usuario con id #{client_params[:telegram_user_id]} no se encuentra registrado"
      }.to_json
    rescue ContentNotFound
      status 404
      {
        :message => 'No viste nada esta semana'
      }.to_json
    end
  end
end
