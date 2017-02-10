require 'sinatra'
require 'json'
require 'pry'
require_relative '../models/beer'

get '/api/beer' do
  beers = Beer.all

  search = params[:search_term]
  unless search.blank?
    beers = beers.where(search_term: search)
  end

  kind = params[:kind]
  unless kind.blank?
    beers = beers.where(kind: kind)
  end

  rating = params[:rating]
  unless rating.blank?
    beers = beers.where(rating: rating)
  end

  beers.to_json
end

get '/api/beer/:id' do |id|
  beer = Beer.find_by_id(id)
  halt 404 if beer.nil?
  beer.to_json
end

post '/api/beer' do
  beer = Beer.new(params)
  halt [400, 'Missing some info'.to_json] unless beer.valid?
  beer.save
  [201, beer.to_json]
end

patch '/api/beer/:id' do |id|
  beer = Beer.find_by(id: id)
  halt 400 if beer.nil?

  params.delete('splat')
  params.delete('captures')

  beer.update(params)
  beer.to_json
end

delete '/api/beer/:id' do |id|
  beer = Beer.find_by_id(id)
  halt 404 if beer.nil?
  beer.destroy
end

beer_kind = {
  1  => 'Pale Ales',
  2  => 'Strong Ales',
  3  => 'Scottish-Style Ales',
  4  => 'Dark Lagers',
  5  => 'Belgian Styles',
  6  => 'Wild/Sour Beers',
  7  => 'Brown Ales',
  8  => 'Pilseners and Pale Lagers',
  9  => 'India Pale Ales',
  10 => 'Porters',
  11 => 'Wheat Beers',
  12 => 'Stouts',
  13 => 'Specialty Beers',
  14 => 'Bocks'
}
