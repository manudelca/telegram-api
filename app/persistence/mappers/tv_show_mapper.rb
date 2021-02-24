require 'rom/transformer'

module Persistence
  module Mappers
    class TvShowMapper
      def call(contents)
        contents.map do |tv_show_attributes|
          build_content_from_attributes(tv_show_attributes)
        end
      end

      def build_content_from_attributes(tv_show_attributes)
        genre = genre_mapper.build_genre_from(tv_show_attributes.genres)
        tv_show = build_tv_show_from(tv_show_attributes, genre)
        episodes = episodes_repo.find_by_tv_show_id(tv_show.id)
        tv_show.episodes = episodes

        tv_show
      end

      def build_tv_show_from(tv_show_attributes, genre)
        TvShow.new(tv_show_attributes.name,
                   tv_show_attributes.audience,
                   tv_show_attributes.duration_minutes,
                   genre,
                   tv_show_attributes.country,
                   tv_show_attributes.director,
                   tv_show_attributes.first_actor,
                   tv_show_attributes.second_actor,
                   tv_show_attributes.id)
      end

      def episodes_repo
        Persistence::Repositories::EpisodesRepo.new(DB)
      end

      def genre_mapper
        GenreMapper.new
      end

      def seasons_mapper
        SeasonMapper.new
      end

      def episodes_mapper
        EpisodeMapper.new
      end
    end
  end
end
