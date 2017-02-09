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
  brewery = Brewery.create(name: params[:name], location: params[:location])
  if brewery.id.nil?
    halt 404
  else
    [201, brewery.to_json]
  end
end
