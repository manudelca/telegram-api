require 'rom/transformer'

module Persistence
  module Mappers
    class TvShowMapper
      def call(contents)
        contents.map do |tv_show|
          build_tv_show_from(tv_show)
        end
      end

      def build_tv_show_from(tv_show_attributes)
        TvShow.new(tv_show_attributes.name, tv_show_attributes.id)
      end
    end
  end
end
