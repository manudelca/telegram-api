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
        contents_relation = (contents.by_pk(id) >> movie_mapper)
        contents_relation.one
      end

      private

      def movie_changeset(movie)
        { name: movie.name }
      end

      def movie_mapper
        Persistence::Mappers::MovieMapper.new
      end
    end
  end
end
