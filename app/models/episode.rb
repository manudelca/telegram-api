class Episode
  attr_reader :number
  attr_accessor :id

  def initialize(number, id = nil)
    @number = number
    @id = id
  end
end
