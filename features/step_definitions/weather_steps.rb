Given('the weather is {string}') do |string|
  @request = { weather: string}.to_json
  @response = Faraday.post(test_weather_url, @request, header)
  answer = JSON.parse(@response.body)
  expect(answer['message']).to eq('ok')
end

Given('I request a content weather suggestion') do
  @response = Faraday.get(weather_suggestion_url, nil, header)
  @content = JSON.parse(@response.body)
end
