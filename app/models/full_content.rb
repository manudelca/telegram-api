require_relative 'content'

class FullContent < Content
  attr_accessor :genre

  def initialize(genre, id)
    raise GenreNotFound if genre.nil?

    super(id)
    @genre = genre
  end
end
