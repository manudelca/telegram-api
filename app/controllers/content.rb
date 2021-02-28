WebTemplate::App.controllers :content, :provides => [:json] do
  post :create, :map => '/content' do
    content_created = []
    content_params[:content].each do |content|
      content_created << create_content_and_get_json(content['type'], content)
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
      releases = Content.releases(content_repo, @@date)
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
      weather_suggestions = Content.weather_suggestions(content_repo, @@weather.current_weather)
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
