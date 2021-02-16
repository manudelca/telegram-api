module Persistence
  module Repositories
    class GenericContentRepo < ROM::Repository[:contents]
      def find(id)
        contents_relation = (contents.combine(:genres, seasons: :episodes).by_pk(id) >> generic_content_mapper)
        contents_relation.one.first
      end

      private

      def generic_content_mapper
        Persistence::Mappers::GenericContentMapper.new
      end
    end
  end
end
