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
      content = generic_content_repo.find(content_id)
      dic_content_type = {
        'movie' => method(:movie_details_response),
        'tv_show' => method(:tv_show_details_response)
      }
      dic_content_type[content.type_of_content][content]
    rescue ContentNotFound => _e
      status 404
      {
        :message => 'Error: id no se encuentra en la coleccion'
      }.to_json
    end
  end

  get :show, :map => '/content/releases' do
  end
end
