require 'faraday'
require 'json'

class WeatherProvider
  attr_accessor :request_status

  def initialize
    @weather = nil
    @request_status = nil
  end

  def define_weather(weather)
    @weather = weather
  end

  def clean_weather
    @weather = nil
  end

  def current_weather
    return @weather unless @weather.nil?

    response = Faraday.get(ENV['WEATHER_URL'], {q: ENV['CITY_NAME'], appid: ENV['APIID']})
    @request_status = response.status
    JSON.parse(response.body)['weather'][0]['main']
  end
end
