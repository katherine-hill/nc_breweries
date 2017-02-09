require 'sinatra'
require 'json'
require 'pry'
require_relative '../models/brewery'

get '/api/brewery' do
  Brewery.all.to_json
end

get '/api/brewery/:id' do |id|
  brewery = Brewery.find_by_id(id)
  halt 404 if brewery.nil?

  brewery_with_beers = JSON.parse(brewery.to_json)
  brewery_with_beers['beers'] = JSON.parse(brewery.beers.to_json)
  brewery_with_beers.to_json
end

post '/api/brewery' do
  brewery = Brewery.new(params)
  halt [400, 'Missing some info'.to_json] unless brewery.valid?
  brewery.save
  [201, brewery.to_json]
end

patch '/api/brewery/:id' do |id|
  brewery = Brewery.find_by(id: id)
  halt 400 if brewery.nil?

  params.delete('splat')
  params.delete('captures')

  brewery.update(params)
  brewery.to_json
end

delete '/api/brewery' do |id|
  brewery = Brewery.find_by_id(id)
  halt 404 if brewery.nil?
  brewery.destroy
end
