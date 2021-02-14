require 'rom/transformer'

module Persistence
  module Mappers
    class MovieMapper
      def call(contents)
        contents.map do |movie|
          build_movie_from(movie)
        end
      end

      def build_movie_from(movie_attributes)
        Movie.new(movie_attributes.name, movie_attributes.id)
      end
    end
  end
end
