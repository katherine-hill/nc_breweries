require 'sinatra'
require 'json'
require_relative '../models/beer'

get '/api/beer' do
  beers = Beer.all

  results = params[:results].to_i || 0
    unless results == 0
      beers = beers.limit(results)
    end
    
  name = params[:name]
  unless name.blank?
    name = name.titleize
    beers = beers.where('name LIKE ?', ['%' + name + '%'])
    halt 404 if beers == []
  end

  kind = params[:kind]
  unless kind.blank?
    kind = kind.titleize #Would be better to downcase this input and the search field.
    beers = beers.where('kind LIKE ?', ['%' + kind + '%']) #< - This causes test to fail,but enables search by partial kind, rather than exact search: (kind: kind).
    halt 404 if beers == []
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
