require 'byebug'

Given('the movie {string}, with type {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string}, release date {string} is created') do |name, type, audience, duration, genre, country, director, first_actor, second_actor, release_date|
  @request = {content: [{type: type, name: name, audience: audience,
                         duration_minutes: duration, genre: genre,
                         country: country, director: director,
                         first_actor: first_actor, second_actor: second_actor,
                         release_date: release_date}]}.to_json
  @response = Faraday.post(create_content_url, @request, header)
  content = JSON.parse(@response.body)
  @contents_list = [] if @contents_list.nil?
  @contents_list << content['content'].first
end

Given('the tv show episode {string}, with type {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string}, release date {string}, season {int} and episode {int} is created') do |tv_show_name, tv_show_type, tv_show_audience, tv_show_duration, tv_show_genre, tv_show_country, tv_show_director, tv_show_first_actor, tv_show_second_actor, tv_show_release_date, season, episode|
  @request = {content: [{type: tv_show_type, name: tv_show_name,
                         audience: tv_show_audience, duration_minutes: tv_show_duration,
                         genre: tv_show_genre, country: tv_show_country,
                         director: tv_show_director, release_date: tv_show_release_date,
                         first_actor: tv_show_first_actor, second_actor: tv_show_second_actor,
                         season_number: season, episode_number: episode}]}.to_json
  @response = Faraday.post(create_content_url, @request, header)
  content = JSON.parse(@response.body)
  @contents_list = [] if @contents_list.nil?
  @contents_list << content['content'].first
end

When('I request releases') do
  @response = Faraday.get(get_releases_url)
end

Then('I should receive id, name, actors, director, genre and season \(if tv show) from {string}, {string}, {string}') do |content_name_one, content_name_two, content_name_three|
  answer = JSON.parse(@response.body)['content']
  content_names = []
  answer.each do |content|
    content_names << content['name']
  end
  expect(content_names[0]).to eq(content_name_one)
  expect(content_names[1]).to eq(content_name_two)
  expect(content_names[2]).to eq(content_name_three)
end

Then('I should receive id, name, actors, director, genre and season \(if tv show) from {string}, {string}') do |content_name_one, content_name_two|
  answer = JSON.parse(@response.body)['content']
  content_names = []
  answer.each do |content|
    content_names << content['name']
  end
  expect(content_names[0]).to eq(content_name_one)
  expect(content_names[1]).to eq(content_name_two)
end

Given('No content is available') do
end

Given('today is {string}') do |today_date|
  @request = { date: today_date}.to_json
  @response = Faraday.post(test_date_url, @request, header)
end
