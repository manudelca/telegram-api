When('I register the genre {string}') do |string|
  @request = {name: string}.to_json
  @response = Faraday.post(create_genre_url, @request, header)
end

Then('I should receive {string} message') do |string|
  answer = JSON.parse(@response.body)
  expect(answer['message']).to eq(string)
end

Then('the genre {string} should be created') do |string|
  answer = JSON.parse(@response.body)
  genre = JSON.parse(answer['genre'])
  expect(genre['name']).to eq(string)
end
