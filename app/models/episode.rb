require_relative 'content'

class Episode < Content
  attr_reader :season_number, :tv_show_id, :number, :release_date
  attr_accessor :id

  def initialize(number, season_number, release_date, tv_show_id, id = nil)
    super(id)
    @season_number = season_number
    @number = number
    @tv_show_id = tv_show_id
    @release_date = release_date
  end

  def is_viewable
    true
  end
end
