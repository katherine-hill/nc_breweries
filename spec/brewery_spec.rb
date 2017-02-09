require_relative '../lib/resources/brewery'
require 'active_record'
require 'json'
require 'rack/test'
require 'rspec'
require 'pry'
require 'environment'

describe 'app' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  #  __  __     __   __     __     ______
  # /\ \/\ \   /\ "-.\ \   /\ \   /\__  _\
  # \ \ \_\ \  \ \ \-.  \  \ \ \  \/_/\ \/
  #  \ \_____\  \ \_\\"\_\  \ \_\    \ \_\
  #   \/_____/   \/_/ \/_/   \/_/     \/_/

  describe Brewery do
    describe '#valid?' do
      context 'when only given a name' do
        it 'returns false' do
          brewery = Brewery.new(name: 'Miller')

          expect(brewery.valid?).to eq false
        end
      end
      context 'when only given a location' do
        it 'returns false' do
          brewery = Brewery.new(location: 'High Point')

          expect(brewery.valid?).to eq false
        end
      end
      context 'when given a name and location' do
        it 'returns true' do
          brewery = Brewery.new(name: 'Miller', location: 'High Point')

          expect(brewery.valid?).to eq true
        end
      end
    end
  end

  #  ______     ______   __
  # /\  __ \   /\  == \ /\ \
  # \ \  __ \  \ \  _-/ \ \ \
  #  \ \_\ \_\  \ \_\    \ \_\
  #   \/_/\/_/   \/_/     \/_/

  describe 'API #get /api/breweries' do
    context 'searching all breweries without filtering' do
      it 'returns all breweries' do

        get '/api/brewery'
          brewery = Brewery.all

          expect(last_response).to be_ok
          expect(last_response.status).to eq 200
      end
    end
  end
end
