module Persistence
  module Repositories
    class GenreRepo < ROM::Repository[:genres]
      commands :create

      def create_genre(genre)
        genre_struct = create(genre_changeset(genre))
        genre.id = genre_struct.id

        genre
      end

      def find_by_genre_name(name, &when_not_found)
        genre_relation = genres.where(name: name)
        genre = (genre_relation >> genre_mapper).first
        return when_not_found.call if genre.nil? && block_given?

        genre
      end

      def find(id)
        genres_relation = (genres.by_pk(id) >> genre_mapper)
        genres_relation.one
      end

      private

      def genre_changeset(genre)
        {name: genre.name}
      end

      def genre_mapper
        Persistence::Mappers::GenreMapper.new
      end
    end
  end
end
