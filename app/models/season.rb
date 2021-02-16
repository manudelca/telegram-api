class Season
  attr_reader :number, :tv_show_id, :episodes
  attr_accessor :id

  def initialize(number, tv_show_id, id = nil, episodes = [])
    @number = number
    @tv_show_id = tv_show_id
    @id = id
    @episodes = episodes
  end

  def number_of_episodes
    episodes.size
  end
end
