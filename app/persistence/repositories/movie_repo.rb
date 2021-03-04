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
        movie = contents_relation.one
        raise ContentNotFound if movie.nil?

        movie
      end

      def find_by_name_and_release_date(name, release_date)
        contents_relation = contents.where(name: name)
                                    .where(release_date: release_date)
                                    .combine(:genres)
        contents_relation = (contents_relation >> movie_mapper)
        contents_relation.first
      end

      def delete_all
        contents.delete
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
