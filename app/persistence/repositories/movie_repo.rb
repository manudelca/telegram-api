module Persistence
  module Repositories
    class MovieRepo < ROM::Repository[:contents]
      private

      def movie_changeset(movie)
        { name: movie.name }
      end
    end
  end
end
