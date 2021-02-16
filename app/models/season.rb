class Season
  attr_reader :tv_show, :number
  attr_accessor :id

  def initialize(tv_show, number, id = nil)
    @tv_show = tv_show
    @number = number
    @id = id
  end
end
