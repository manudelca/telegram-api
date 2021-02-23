module Persistence
  module Repositories
    class ContentRepo < ROM::Repository[:contents]
      def find(id)
        contents_relation = (contents.combine(:genres, seasons: :episodes).by_pk(id) >> content_mapper)
        contents_relation.one
      end

      def delete_all
        contents.delete
      end

      private

      def content_mapper
        Persistence::Mappers::ContentMapper.new
      end
    end
  end
end
