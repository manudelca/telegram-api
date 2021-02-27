Given('the weather is {string}') do |string|
  @request = { weather: string}.to_json
  @response = Faraday.post(test_weather_url, @request, header)
  answer = JSON.parse(@response.body)
  expect(answer['message']).to eq('ok')
end

Given('I request a content sugestion') do
  pending # Write code here that turns the phrase above into concrete actions
end
