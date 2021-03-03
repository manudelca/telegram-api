require 'spec_helper'

describe Content do
  let(:content) { described_class.new(1) }

  it 'content is viewable should raise error' do
    expect { content.is_viewable }.to raise_error(ShoulBeImplementedInDerivedClassesError)
  end

  it 'content class should return comedy content when weather is clear' do # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations, Metrics/BlockLength
    date = Time.parse('2020-02-03')
    date_provider = DateProvider.new
    date_provider.define_now_date(date)
    weather = 'Clear'
    genre_repository = Persistence::Repositories::GenreRepo.new(DB)
    movie_repo = Persistence::Repositories::MovieRepo.new(DB)
    content_repo = Persistence::Repositories::ContentRepo.new(DB)
    new_genre = Genre.new('comedia')
    other_genre = Genre.new('terror')
    genre = genre_repository.create_genre(new_genre)
    other_genre = genre_repository.create_genre(other_genre)

    movie1 = Movie.new('Titanico 1', 'No ATP', 190, genre, 'USA', 'James Cameron', '2018-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie2 = Movie.new('Titanico 2', 'No ATP', 190, genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie3 = Movie.new('Titanico 3', 'No ATP', 190, genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie4 = Movie.new('Amanecer de los muertos', 'No ATP', 190, other_genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie5 = Movie.new('Amanecer de los muertos 2', 'No ATP', 190, other_genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie6 = Movie.new('Amanecer de los muertos 3', 'No ATP', 190, other_genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')

    saved_movie1 = movie_repo.create_content(movie1)
    saved_movie2 = movie_repo.create_content(movie2)
    saved_movie3 = movie_repo.create_content(movie3)
    movie_repo.create_content(movie4)
    movie_repo.create_content(movie5)
    movie_repo.create_content(movie6)

    movies = described_class.weather_suggestions(content_repo, weather, date_provider)

    expect(movies.size).to eq(3)
    expect(movies[0].id).to eq(saved_movie1.id)
    expect(movies[1].id).to eq(saved_movie2.id)
    expect(movies[2].id).to eq(saved_movie3.id)
  end

  it 'content class should return action content when weather is clouds' do # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations, Metrics/BlockLength
    date = Time.parse('2020-02-03')
    date_provider = DateProvider.new
    date_provider.define_now_date(date)
    weather = 'Clouds'
    genre_repository = Persistence::Repositories::GenreRepo.new(DB)
    movie_repo = Persistence::Repositories::MovieRepo.new(DB)
    content_repo = Persistence::Repositories::ContentRepo.new(DB)
    new_genre = Genre.new('accion')
    other_genre = Genre.new('terror')
    genre = genre_repository.create_genre(new_genre)
    other_genre = genre_repository.create_genre(other_genre)

    movie1 = Movie.new('Titanico 1', 'No ATP', 190, genre, 'USA', 'James Cameron', '2018-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie2 = Movie.new('Titanico 2', 'No ATP', 190, genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie3 = Movie.new('Titanico 3', 'No ATP', 190, genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie4 = Movie.new('Amanecer de los muertos', 'No ATP', 190, other_genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie5 = Movie.new('Amanecer de los muertos 2', 'No ATP', 190, other_genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie6 = Movie.new('Amanecer de los muertos 3', 'No ATP', 190, other_genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')

    saved_movie1 = movie_repo.create_content(movie1)
    saved_movie2 = movie_repo.create_content(movie2)
    saved_movie3 = movie_repo.create_content(movie3)
    movie_repo.create_content(movie4)
    movie_repo.create_content(movie5)
    movie_repo.create_content(movie6)

    movies = described_class.weather_suggestions(content_repo, weather, date_provider)

    expect(movies.size).to eq(3)
    expect(movies[0].id).to eq(saved_movie1.id)
    expect(movies[1].id).to eq(saved_movie2.id)
    expect(movies[2].id).to eq(saved_movie3.id)
  end

  it 'Default action if no content is found, it should return releases' do # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations, Metrics/BlockLength
    date = Time.parse('2020-02-03')
    date_provider = DateProvider.new
    date_provider.define_now_date(date)
    weather = 'Clouds'
    genre_repository = Persistence::Repositories::GenreRepo.new(DB)
    movie_repo = Persistence::Repositories::MovieRepo.new(DB)
    content_repo = Persistence::Repositories::ContentRepo.new(DB)
    client_repo = Persistence::Repositories::ClientRepo.new(DB)
    client_repo.delete_all
    content_repo.delete_all
    genre_repository.delete_all

    new_genre = Genre.new('romatica')
    other_genre = Genre.new('terror')
    genre = genre_repository.create_genre(new_genre)
    other_genre = genre_repository.create_genre(other_genre)

    movie1 = Movie.new('Titanico 1', 'No ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie2 = Movie.new('Titanico 2', 'No ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie3 = Movie.new('Titanico 3', 'No ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie4 = Movie.new('Amanecer de los muertos', 'No ATP', 190, other_genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie5 = Movie.new('Amanecer de los muertos 2', 'No ATP', 190, other_genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie6 = Movie.new('Amanecer de los muertos 3', 'No ATP', 190, other_genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')

    saved_movie1 = movie_repo.create_content(movie1)
    saved_movie2 = movie_repo.create_content(movie2)
    saved_movie3 = movie_repo.create_content(movie3)
    movie_repo.create_content(movie4)
    movie_repo.create_content(movie5)
    movie_repo.create_content(movie6)

    movies = described_class.weather_suggestions(content_repo, weather, date_provider)

    expect(movies.size).to eq(3)
    expect(movies[0].id).to eq(saved_movie1.id)
    expect(movies[1].id).to eq(saved_movie2.id)
    expect(movies[2].id).to eq(saved_movie3.id)
  end

  it 'Default action if weather isnt mapped' do # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations, Metrics/BlockLength
    date = Time.parse('2020-02-03')
    date_provider = DateProvider.new
    date_provider.define_now_date(date)
    weather = 'Not a mapped weather'
    genre_repository = Persistence::Repositories::GenreRepo.new(DB)
    movie_repo = Persistence::Repositories::MovieRepo.new(DB)
    content_repo = Persistence::Repositories::ContentRepo.new(DB)
    client_repo = Persistence::Repositories::ClientRepo.new(DB)
    client_repo.delete_all
    content_repo.delete_all
    genre_repository.delete_all

    new_genre = Genre.new('romatica')
    other_genre = Genre.new('terror')
    genre = genre_repository.create_genre(new_genre)
    other_genre = genre_repository.create_genre(other_genre)

    movie1 = Movie.new('Titanico 1', 'No ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie2 = Movie.new('Titanico 2', 'No ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie3 = Movie.new('Titanico 3', 'No ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie4 = Movie.new('Amanecer de los muertos', 'No ATP', 190, other_genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie5 = Movie.new('Amanecer de los muertos 2', 'No ATP', 190, other_genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
    movie6 = Movie.new('Amanecer de los muertos 3', 'No ATP', 190, other_genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')

    saved_movie1 = movie_repo.create_content(movie1)
    saved_movie2 = movie_repo.create_content(movie2)
    saved_movie3 = movie_repo.create_content(movie3)
    movie_repo.create_content(movie4)
    movie_repo.create_content(movie5)
    movie_repo.create_content(movie6)

    movies = described_class.weather_suggestions(content_repo, weather, date_provider)

    expect(movies.size).to eq(3)
    expect(movies[0].id).to eq(saved_movie1.id)
    expect(movies[1].id).to eq(saved_movie2.id)
    expect(movies[2].id).to eq(saved_movie3.id)
  end

  it 'content is listable should raise error' do
    expect { content.is_listable }.to raise_error(ShoulBeImplementedInDerivedClassesError)
  end

  it 'content wih same id is the same content' do
    genre = Genre.new('Drama')
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate')
    Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie)

    saved_movie = Persistence::Repositories::ContentRepo.new(DB).find(movie.id)
    expect(movie).to eq(saved_movie)
  end
end
