require_relative 'content'

class Season < Content
  attr_reader :number, :tv_show_id, :release_date, :episodes
  attr_accessor :id

  def initialize(number, tv_show_id, release_date, id = nil, episodes = [])
    super(id)
    @number = number
    @tv_show_id = tv_show_id
    @release_date = release_date
    @episodes = episodes
  end

  def number_of_episodes
    episodes.size
  end

  def is_viewable
    false
  end

  def update_release_date(new_release_date)
    @release_date = new_release_date
  end
end
