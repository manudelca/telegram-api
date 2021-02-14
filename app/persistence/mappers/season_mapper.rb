require 'rom/transformer'

module Persistence
  module Mappers
    class SeasonMapper
      def call(seasons)
        seasons.map do |season|
          tv_show = tv_show_mapper.build_tv_show_from(season.content)
          build_season_from(season, tv_show)
        end
      end

      def build_season_from(season_attributes, tv_show)
        Season.new(tv_show, season_attributes.number, season_attributes.id)
      end

      def tv_show_mapper
        TvShowMapper.new
      end
    end
  end
end
