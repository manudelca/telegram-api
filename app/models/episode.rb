class Episode
  attr_reader :season, :number
  attr_accessor :id

  def initialize(season, number, id = nil)
    @season = season
    @number = number
    @id = id
  end

  def hash
    [@id].hash # El valor segun el que hashee
    # tiene que ser los mismos segun
    # los que compare
  end

  def eql?(other)
    @id == other.id
    # misma duda que movie
  end
end
