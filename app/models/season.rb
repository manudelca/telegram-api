class Season
  attr_reader :number, :tv_show_id, :release_date, :episodes
  attr_accessor :id

  def initialize(number, tv_show_id, release_date, id = nil, episodes = [])
    @number = number
    @tv_show_id = tv_show_id
    @release_date = release_date
    @id = id
    @episodes = episodes
  end

  def number_of_episodes
    episodes.size
  end

  def update_release_date(new_release_date)
    @release_date = new_release_date
  end
end
