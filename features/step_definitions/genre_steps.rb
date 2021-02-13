When('I register the genre {string}') do |string|
  @request = {name: string}.to_json
  @response = Faraday.post(create_genre_url, @request, header)
end

Then('I should receive {string} message') do |string|
  expect(@response.status).to eq(201)
  answer = JSON.parse(@response.body)
  expect(answer['message']).to eq(string)
end
