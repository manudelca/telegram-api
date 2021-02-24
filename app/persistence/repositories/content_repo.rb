module Persistence
  module Repositories
    class ContentRepo < ROM::Repository[:contents]
      def find(id)
        content_relation = (contents.combine(:genres).by_pk(id) >> content_mapper)
        content_relation.one
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
