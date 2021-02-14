require 'rom/transformer'

module Persistence
  module Mappers
    class SeasonMapper
      def call(seasons)
        seasons.map do |season|
          build_season_from(season)
        end
      end

      def build_season_from(season_attributes)
        Season.new(season_attributes.number, season_attributes.id)
      end
    end
  end
end
