require_relative 'api'
require 'sinatra'
require 'json'
require 'rack/test'
require 'rspec'
require 'pry'

get '/api/breweries' do
  Brewery.all.to_json
end

# get '/api/breweries/:id' do |id|
#   brewery = Brewery.find_by_id(id)
#   if brewery.nil?
#     halt 404
#   else
#     brewery_with_beers = JSON.parse(brewery.to_json)
#     brewery_with_beers['beers'] = JSON.parse(brewery.beers.to_json)
#     brewery_with_beers.to_json
#   end
# end

post '/api/breweries' do
  brewery = Brewery.create(name: params[:name], location: params[:location])
  if brewery.id.blank?
    halt 404
  else
    [201, brewery.to_json]
  end
end
