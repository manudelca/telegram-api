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

  # no encontramos manera limpia de hacerlo
  get :show, :map => '/content', :with => :id do
    content_id = params[:id]
    begin
      content = find_content(content_id)
      dic_content_type = {
        'movie' => method(:movie_details_response),
        'tv_show' => method(:tv_show_details_response)
      }
      raise ContentTypeNotValid unless dic_content_type.include?(content.type_of_content)

      dic_content_type[content.type_of_content][content]
    rescue ContentNotFound, RepoNotFound, ContentTypeNotValid => _e
      status 404
      {
        :message => 'Error: id no se encuentra en la coleccion'
      }.to_json
    end
  end

  get :show, :map => '/content' do
    begin
      query_type = content_params[:query_type]
      raise QueryNotImplementedError unless query_type.eql?('releases')

      number_of_releases = 3
      releases = generic_content_repo.find_by_desc_release_date(number_of_releases)
      releases_formatted = []
      releases.each do |release|
        dic_content_type = {
          'movie' => method(:movie_as_release_to_json),
          'tv_show' => method(:tv_show_as_release_to_json)
        }
        releases_formatted << dic_content_type[release.type_of_content][release]
      end

      status 200
      {
        :message => 'El contenido fue encontrado exitosamente!',
        :content => releases_formatted
      }.to_json
    rescue QueryNotImplementedError
      status 400
      {
        :message => 'Error: invalid query type'
      }.to_json
    end
  end
end
