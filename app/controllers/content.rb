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
    movie = movie_repo.find(content_id)

    status 200
    {
      :message => 'El contenido fue encontrado!',
      :content => movie_details_to_json(movie)
    }.to_json
  end
end
