module Persistence
  module Repositories
    class GenreRepo < ROM::Repository[:genres]
      commands :create

      def genre_changeset(genre)
        {name: genre.name}
      end
    end
  end
end
