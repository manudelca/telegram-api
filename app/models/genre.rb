class Genre
  attr_reader :name
  attr_accessor :id

  def initialize(name, id = nil)
    raise NoNameError if name.nil?

    @name = name
    @id = id
  end
end
