class Genre
  attr_reader :name
  attr_accessor :id

  def initialize(name, id = nil)
    @name = name
    @id = id
  end
end
