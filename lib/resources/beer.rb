require_relative 'api'
require 'sinatra'
require 'json'
require 'rack/test'
require 'rspec'
require 'pry'

get '/api/beers' do
  Beer.all.to_json

  #name kind description foreign_key



end





get '/api/beers/:id' do |id|
  beer = Beer.find_by_id(id)
  halt 404 if beer.id.blank?
  beer.to_json
end

post '/api/beers' do
  beer = Beer.create(params)
  halt 404 if beer.id.blank?
  [201, beer.to_json]
end
