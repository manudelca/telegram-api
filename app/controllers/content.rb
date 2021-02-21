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
      content = find_content(content_id)
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
      number_of_releases = 3
      movie_releases = movie_repo.find_by_desc_release_date(number_of_releases)
      tv_show_releases = tv_show_repo.find_by_desc_release_date(number_of_releases)

      releases = []
      releases += movie_releases unless movie_releases.nil?
      releases += tv_show_releases unless tv_show_releases.nil?

      raise ContentNotFound if releases.empty?

      last_releases = releases.sort_by(&:release_date).reverse!.first(number_of_releases)
      releases_formatted = []
      last_releases.each do |release|
        releases_formatted << release.as_release
      end

      status 200
      {
        :message => 'El contenido fue encontrado exitosamente!',
        :content => releases_formatted
      }.to_json
    rescue ContentNotFound
      status 200
      {
        :message => 'No se encontro contenido!',
        :content => []
      }.to_json
    end
  end
end
