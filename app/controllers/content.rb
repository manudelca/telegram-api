WebTemplate::App.controllers :content, :provides => [:json] do
  post :create, :map => '/content' do
    movie = Movie.new(content_params[0][:name])
    # new_movie = movie_repo.create_movie(movie)
    # content_params.each do |content|

    # end
    # genre = Genre.new(genre_params[:name])
    # new_genre = genre_repo.create_genre(genre)

    status 201
    {
      :message => 'El contenido fue registrado exitosamente!',
      :content => movie_to_json(movie)
    }.to_json
  end
end
