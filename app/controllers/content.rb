WebTemplate::App.controllers :content, :provides => [:json] do
  post :create, :map => '/content' do
    movie = Movie.new(content_params[0][:name])
    new_movie = movie_repo.create_content(movie)
    # content_params.each do |content|

    # end

    status 201
    {
      :message => 'El contenido fue registrado exitosamente!',
      :content => movie_to_json(new_movie)
    }.to_json
  end
end
