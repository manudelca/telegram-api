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
    # primero se fija si es una movie
    content_id = params[:id]
    begin
      movie = movie_repo.find(content_id)
      movie_details_response(movie)
    rescue ContentNotFound => _e
      # no hay contenido con ese id
      status 404
      {
        :message => 'Error: id no se encuentra en la coleccion'
      }.to_json
    rescue StandardError => _e
      # tiene que ser un tv_show
      tv_show = tv_show_repo.find(content_id)
      tv_show_details_response(tv_show)
    end
  end
end
