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

  def is_equal_to_episode?(episode)
    @id == episode.id
  end

  def is_equal_to_movie?(movie)
    false
  end

  def eql?(other)
    other.is_equal_to_episode?(self)
    # misma duda que movie
  end
end
