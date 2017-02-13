require 'sinatra'
require 'json'
require_relative '../models/beer'

get '/api/beer' do
  beers = Beer.all
  # results = 5
  # beers = beers.limit(results)
  # before "/comments/?" do
  # params[:start] ||= 0
  # end

  #start = params[:start] || 0
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
    kind = kind.titleize
    beers = beers.where('kind LIKE ?', ['%' + kind + '%'])
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
