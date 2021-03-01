require 'byebug'

Given('the api key is {string}') do |api_key|
  @request = { api_key: api_key}.to_json
  @response = Faraday.post(test_api_key_url, @request, header)
end

When('I make a request with the api key {string}') do |api_key|
  @response = Faraday.get(alive_url, header_with_api_key(api_key))
end

Then('I should receive the request answer') do
  expect(@response.status).not_to eq(401)
end
