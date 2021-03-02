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

  def is_listable
    false
  end

  def can_be_a_release
    true
  end

  def can_be_a_weather_suggestion
    false
  end

  def as_seen
    @output_parser.seen_json(self)
  end

  def as_release
    @output_parser.release_json(self)
  end

  def as_weather_suggestion
    as_release
  end
end
