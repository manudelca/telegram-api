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

  def type_of_content
    'movie'
  end
end
