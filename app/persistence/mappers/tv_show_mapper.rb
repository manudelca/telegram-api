require 'rom/transformer'

module Persistence
  module Mappers
    class TvShowMapper
      def call(contents)
        contents.map do |tv_show|
          genre = genre_mapper.build_genre_from(tv_show.genres)
          build_tv_show_from(tv_show, genre)
        end
      end

      def build_tv_show_from(tv_show_attributes, genre)
        TvShow.new(tv_show_attributes.name,
                   tv_show_attributes.audience,
                   tv_show_attributes.duration_minutes,
                   genre,
                   tv_show_attributes.country,
                   tv_show_attributes.director,
                   tv_show_attributes.release_date,
                   tv_show_attributes.first_actor,
                   tv_show_attributes.second_actor)
      end

      def genre_mapper
        GenreMapper.new
      end
    end
  end
end
