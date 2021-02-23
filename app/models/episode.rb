require_relative 'content'

class Episode < Content
  attr_reader :season_id, :number
  attr_accessor :id

  def initialize(number, season_id, id = nil)
    super(id)
    @season_id = season_id
    @number = number
  end

  def is_viewable
    true
  end
end
