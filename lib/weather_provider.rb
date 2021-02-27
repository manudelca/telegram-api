class WeatherProvider
  attr_accessor :request_status

  WEATHER_URL = 'http://api.openweathermap.org/data/2.5/weather'.freeze
  CITY_NAME = 'Buenos Aires, AR'.freeze
  APIID = '1173731405631f686cd4d997a83ff01f'.freeze

  def initialize
    @weather = nil
    @request_status = nil
  end

  def define_weather(weather)
    @weather = weather
  end

  def current_weather
    return @weather unless @weather.nil?

    response = Faraday.get(WEATHER_URL, {q: CITY_NAME, appid: APIID})
    @request_status = response.status
    JSON.parse(response.body)['weather'][0]['main']
  end
end
