require 'rom/transformer'

module Persistence
  module Mappers
    class MovieMapper
      def call(contents)
        contents.map do |movie_attributes|
          build_content_from_attributes(movie_attributes)
        end
      end

      def build_content_from_attributes(movie_attributes)
        genre = genre_mapper.build_genre_from(movie_attributes.genres)
        build_movie_from(movie_attributes, genre)
      end

      def build_movie_from(movie_attributes, genre)
        Movie.new(movie_attributes.name,
                  movie_attributes.audience,
                  movie_attributes.duration_minutes,
                  genre,
                  movie_attributes.country,
                  movie_attributes.director,
                  movie_attributes.release_date,
                  movie_attributes.first_actor,
                  movie_attributes.second_actor,
                  movie_attributes.id)
      end

      def genre_mapper
        GenreMapper.new
      end
    end
  end
end
