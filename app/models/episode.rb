require_relative '../presentation/episode_output_parser'
require_relative 'content'

class Episode < Content
  attr_reader :season_number, :number, :release_date
  attr_accessor :id, :tv_show

  def initialize(number, season_number, release_date, id = nil,
                 output_parser = EpisodeOutputParser.new)
    super(id)
    @season_number = season_number
    @number = number
    @release_date = release_date
    @output_parser = output_parser
  end

  def is_viewable
    true
  end
end
