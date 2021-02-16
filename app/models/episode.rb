class Episode
  attr_reader :season_id, :number
  attr_accessor :id

  def initialize(number, season_id, id = nil)
    @season_id = season_id
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

  def is_equal_to_movie?(_movie)
    false
  end

  def eql?(other)
    other.is_equal_to_episode?(self)
    # misma duda que movie
  end
end
