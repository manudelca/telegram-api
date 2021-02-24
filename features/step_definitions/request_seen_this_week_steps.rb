require 'byebug'
Given('the movie {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string}, release date {string}') do |name, audience, duration, genre, country, director, first_actor, second_actor, release_date|
  @request = {name: genre}.to_json
  @response = Faraday.post(create_genre_url, @request, header)
  @request = {content: [{type: 'movie', name: name, audience: audience,
                         duration_minutes: duration, genre: genre,
                         country: country, director: director,
                         first_actor: first_actor, second_actor: second_actor,
                         release_date: release_date}]}.to_json
  @response = Faraday.post(create_content_url, @request, header)

  content = JSON.parse(@response.body)
  @content_id = content['content'].first['id']
  if !@contents_ids
    @contents_ids = {name => content['content'][0]}
  else
    @contents_ids[name] = content['content'][0]
  end
end

Given('the episode  the tv show {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string}, season {int} and episode {int}, release date {string}') do |name, audience, duration, genre, country, director, first_actor, second_actor, episode, season, release_date|
  @request = {name: genre}.to_json
  @response = Faraday.post(create_genre_url, @request, header)
  @request = {content: [{type: 'tv_show', name: name, audience: audience,
                         duration_minutes: duration, genre: genre,
                         country: country, director: director,
                         first_actor: first_actor, second_actor: second_actor,
                         release_date: release_date,
                         season_number: season, episode_number: episode}]}.to_json
  @response = Faraday.post(create_content_url, @request, header)

  content = JSON.parse(@response.body)
  @content_id = content['content'].first['id']
  if !@contents_ids
    @contents_ids = {name => content['content'][0]}
  else
    @contents_ids[name] = content['content'][0]
  end
end

Given('{string} saw the movie {string} in {string}') do |email, name, _date|
  @user_id = 0
  content_id = @contents_ids[name]['id']
  @request = {email: email, telegram_user_id: @user_id}.to_json
  @response = Faraday.post(client_url, @request, header)
  @response = Faraday.patch(views_url(email, content_id), header)
end

Given('{string} saw the tv show {string}, season {int} episode {int} in {string}') do |email, name, _season, _episode, _date|
  @user_id = 0
  content_id = @contents_ids[name]['id']
  @request = {email: email, telegram_user_id: @user_id}.to_json
  @response = Faraday.post(client_url, @request, header)
  @response = Faraday.patch(views_url(email, content_id), header)
end

Given('I haven\'t qualified any content') do
end

When('I request content seen this week') do
  @request = {telegram_user_id: @user_id}.to_json
  @response = Faraday.post(seen_this_week_url, @request, header)
  @content = JSON.parse(@response.body)
end

Then('I should receive name, {int} actors, el director, genre and season \(if tv show) from {string}, {string}. {string}') do |_int, name1, name2, name3|
  n0 = @content['content'][0]['name']
  n1 = @content['content'][1]['name']
  n2 = @content['content'][2]['name']
  raise "Content's names don't match" if (n0 != name1 && n0 != name2 && n0 != name3) || (n1 != name1 && n1 != name2 && n1 != name3) || (n2 != name1 && n2 != name2 && n2 != name3)

  expect(@contents_ids[n0]['first_actor']).to eq(@content['content'][0]['first_actor'])
  expect(@contents_ids[n1]['first_actor']).to eq(@content['content'][1]['first_actor'])
  expect(@contents_ids[n2]['first_actor']).to eq(@content['content'][2]['first_actor'])
  expect(@contents_ids[n0]['second_actor']).to eq(@content['content'][0]['second_actor'])
  expect(@contents_ids[n1]['second_actor']).to eq(@content['content'][1]['second_actor'])
  expect(@contents_ids[n2]['second_actor']).to eq(@content['content'][2]['second_actor'])
  expect(@contents_ids[n0]['director']).to eq(@content['content'][0]['director'])
  expect(@contents_ids[n1]['director']).to eq(@content['content'][1]['director'])
  expect(@contents_ids[n2]['director']).to eq(@content['content'][2]['director'])
  expect(@contents_ids[n0]['genre']).to eq(@content['content'][0]['genre'])
  expect(@contents_ids[n1]['genre']).to eq(@content['content'][1]['genre'])
  expect(@contents_ids[n2]['genre']).to eq(@content['content'][2]['genre'])
  expect(@contents_ids[n0]['season']).to eq(@content['content'][0]['season'])
  expect(@contents_ids[n1]['season']).to eq(@content['content'][1]['season'])
  expect(@contents_ids[n2]['season']).to eq(@content['content'][2]['season'])
end
