require 'spec_helper'

describe WeatherProvider do
  let(:weather_provider) { described_class.new }

  it 'should let you set and get a weather' do
    weather = 'Clear'
    weather_provider.define_weather(weather)

    expect(weather_provider.current_weather).to eq(weather)
  end
end
