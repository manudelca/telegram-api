require 'rom/transformer'

module Persistence
  module Mappers
    class GenreMapper
      def call(genres)
        genres.map do |genre|
          build_genre_from(genre)
        end
      end

      def build_genre_from(genre_attributes)
        Genre.new(genre_attributes.name, genre_attributes.id)
      end
    end
  end
end
