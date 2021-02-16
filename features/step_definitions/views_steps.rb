Given('the movie {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string} and release date {string} is available') do |string, string2, int, string3, string4, string5, string6, string7, string8|
  @request = {name: string3}.to_json
  @response = Faraday.post(create_genre_url, @request, header)
  @request = {content: [{type: 'movie', name: string, audience: string2,
                         duration_minutes: int, genre: string3,
                         country: string4, director: string5,
                         first_actor: string6, second_actor: string7,
                         release_date: string8}]}.to_json
  @response = Faraday.post(create_content_url, @request, header)

  content = JSON.parse(@response.body)
  @content_id = content['content'].first['id']
end

Given('the user {string} {string} is registered') do |string, string2|
  @request = {email: string, username: string2}.to_json
  @response = Faraday.post(client_url, @request, header)
end

When('I marked the movie as seen for {string}') do |string|
  @request = {username: string, movie_id: @content_id}.to_json
  @response = Faraday.patch(views_url, @request, header)
end

Then('I should get {string}') do |string|
  answer = JSON.parse(@response.body)
  expect(answer['message']).to eq(string)
end
