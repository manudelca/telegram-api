WebTemplate::App.controllers :genre, :provides => [:json] do
  post :create, :map => '/genre' do
    genre = Genre.new(genre_params[:name])
    new_genre = genre_repo.create_genre(genre)

    status 201
    {
      :message => "Genero #{new_genre.name} fue registrado exitosamente!",
      :genre => genre_to_json(new_genre)
    }.to_json
  end
end
