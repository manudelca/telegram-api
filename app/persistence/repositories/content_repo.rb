module Persistence
  module Repositories
    class ContentRepo < ROM::Repository[:contents]
      def find(id)
        content_relation = (contents.combine(:genres).by_pk(id) >> content_mapper)
        content_relation.one
      end

      def find_before_date_and_first_newer(date)
        contents_relation = (contents.combine(:genres)
                                     .where { release_date < date }
                                     .order { release_date.desc } >> content_mapper)
        contents = []
        contents_relation.each { |content| contents << content }
        contents
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
