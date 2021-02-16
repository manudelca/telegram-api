module Persistence
  module Repositories
    class MovieRepo < ROM::Repository[:contents]
      commands :create

      def create_content(movie)
        movie_struct = create(movie_changeset(movie))
        movie.id = movie_struct.id

        movie
      end

      def find(id)
        contents_relation = (contents.combine(:genres).by_pk(id) >> movie_mapper)
        contents_relation.one
      end

      private

      def movie_changeset(movie)
        {
          name: movie.name,
          audience: movie.audience,
          duration_minutes: movie.duration_minutes,
          genre_id: movie.genre.id,
          country: movie.country,
          director: movie.director,
          release_date: movie.release_date,
          first_actor: movie.first_actor,
          second_actor: movie.second_actor,
          type: 'movie'
        }
      end

      def movie_mapper
        Persistence::Mappers::MovieMapper.new
      end
    end
  end
end
