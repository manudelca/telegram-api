class WeatherProvider
  def initialize
    @weather = nil
  end

  def define_weather(weather)
    @weather = weather
  end

  def current_weather
    @weather
  end
end
