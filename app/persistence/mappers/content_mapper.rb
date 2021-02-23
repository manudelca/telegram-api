require 'rom/transformer'

module Persistence
  module Mappers
    class ContentMapper
      def call(contents)
        contents.map do |content_attributes|
          dic_content_mappers = {
            'movie' => MovieMapper,
            'tv_show' => TvShowMapper,
            'episode' => EpisodeMapper
          }
          dic_content_mappers[content_attributes.type].new.build_content_from_attributes(content_attributes)
        end
      end
    end
  end
end
