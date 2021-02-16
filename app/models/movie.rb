class Movie
  attr_reader :name, :audience, :duration_minutes,
              :genre, :country, :director,
              :release_date, :first_actor,
              :second_actor
  attr_accessor :id

  def initialize(name, audience, duration_minutes,
                 genre, country, director,
                 release_date, first_actor, second_actor = nil,
                 id = nil)
    @name = name
    @audience = audience
    @duration_minutes = duration_minutes
    @genre = genre
    @country = country
    @director = director
    @release_date = release_date
    @first_actor = first_actor
    @second_actor = second_actor
    @id = id
  end

  def hash
    [@id].hash # El valor segun el que hashee
    # tiene que ser los mismos segun
    # los que compare
  end

  def is_equal_to_episode?(episode)
    false
  end

  def is_equal_to_movie?(movie)
    @id == movie.id
  end

  def eql?(other)
    other.is_equal_to_movie?(self)
    # Deberia chequear el id o algo mas bien de nivel de objetos
    # como el titulo?
  end
end
