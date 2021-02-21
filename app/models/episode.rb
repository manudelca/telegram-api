class Episode
  attr_reader :season_id, :number
  attr_accessor :id

  def initialize(number, season_id, id = nil)
    @season_id = season_id
    @number = number
    @id = id
  end

  def type_of_content
    'episode'
  end
end
