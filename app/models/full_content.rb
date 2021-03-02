require_relative 'content'

class FullContent < Content
  attr_accessor :genre

  def initialize(genre, id)
    super(id)
    @genre = genre
  end
end
