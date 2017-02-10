require 'sinatra'
require 'json'
require 'pry'
require_relative '../models/brewery'
require 'sinatra/json'

get '/api/brewery' do
  json Brewery.all
end

get '/api/brewery/:id' do |id|
  brewery = Brewery.find_by_id(id)
  
  halt 404 if brewery.nil?

  json brewery
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
