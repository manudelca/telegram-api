WebTemplate::App.controllers :genre, :provides => [:json] do
  post :create, :map => '/genre' do
    genre = Genre.new(genre_params[:name])
    new_genre = genre_repo.create_genre(genre)

    status 201
    genre_to_json new_genre
  end
end
