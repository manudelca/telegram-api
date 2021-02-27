require 'spec_helper'

describe WeatherProvider do
  let(:weather_provider) { described_class.new }

  it 'should let you set and get a weather' do
    weather = 'Clear'
    weather_provider.define_weather(weather)

    expect(weather_provider.current_weather).to eq(weather)
  end

  it 'should request an api when no weather was set' do
    weather_provider.current_weather

    expect(weather_provider.request_status).to eq(200)
  end
end
