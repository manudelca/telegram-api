class Episode
  attr_reader :season, :number
  attr_accessor :id

  def initialize(season, number, id = nil)
    @season = season
    @number = number
    @id = id
  end
end
