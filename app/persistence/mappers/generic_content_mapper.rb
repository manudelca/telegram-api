require 'rom/transformer'

module Persistence
  module Mappers
    class GenericContentMapper
      def call(contents)
        contents.map do |content|
          dic_content_mappers = {
            'movie' => MovieMapper,
            'tv_show' => TvShowMapper
          }
          dic_content_mappers[content.type].new.call(contents)
        end
      end
    end
  end
end
