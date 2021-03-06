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

Given('the user {string} is registered') do |string|
  @request = {email: string, user_id: 999}.to_json
  @response = Faraday.post(client_url, @request, header)
end

When('I marked the movie as seen for {string}') do |email|
  @response = Faraday.patch(views_url(email, @content_id), nil, header)
end

Then('I should get {string}') do |string|
  answer = JSON.parse(@response.body)
  expect(answer['message']).to eq(string)
end

Given('there is no movie with id {int}') do |int|
  @content_id = int
end

Given('the episode  the tv show {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string}, seasons {int} and episodes {int} and release date {string} is available') do |string, string2, int, string3, string4, string5, string6, string7, int2, int3, string8|
  @request = {name: string3}.to_json
  @response = Faraday.post(create_genre_url, @request, header)
  @request = {content: [{type: 'tv_show', name: string,
                         audience: string2, duration_minutes: int,
                         genre: string3, country: string4,
                         director: string5, release_date: string8,
                         first_actor: string6, second_actor: string7,
                         season_number: int2, episode_number: int3 }]}.to_json
  @response = Faraday.post(create_content_url, @request, header)

  content = JSON.parse(@response.body)
  @episode_id = content['content'].first['id']
end

When('I marked the episode {int} of tv show {string} for {string}') do |_int, _string, string2|
  @response = Faraday.patch(views_url(string2, @episode_id), nil, header)
end
