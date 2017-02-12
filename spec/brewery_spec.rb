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

  describe 'API #get /api/brewery' do
    context 'searching all breweries without filtering' do
      it 'returns all breweries' do
        get '/api/brewery'
          brewery = Brewery.all

          expect(last_response).to be_ok
          expect(last_response.status).to eq 200
      end
    end
  end

  describe 'API #get /api/brewery/:id' do
    context 'calling one brewery' do
      it 'returns a single brewery and all associated beers' do
        get '/api/brewery/2'

        expect(last_response).to be_ok
        # expect(last_response.body).to include('Sierra')
        # expect(last_response.body).to include('Summerfest')
        expect(last_response.status).to eq 200
      end
    end
  end

  describe 'API #post /api/brewery' do
    context 'creating a new brewery' do
      it 'creates a single brewery' do
        post '/api/brewery?name=Oskar%20Blues&location=Brevard'

        expect(last_response.body).to include('Oskar')
        expect(last_response.status).to eq 201
      end
    end

    context 'incorrectly creating a new brewery' do
      it 'fails to create a brewery when missing values' do
        post '/api/brewery?location=Brevard'

        expect(last_response.body).to include('Missing')
        expect(last_response.status).to eq 400
      end
    end
  end

  describe 'API #patch /api/brewery' do
    context 'updates an existing brewery' do
      it 'updates a single value or multiple values for a single brewery.' do
        patch '/api/brewery/6?location=Charlotte'

        expect(last_response.body).to include('Charlotte')
        expect(last_response.status).to eq 200
      end
    end
  end

  describe 'API #delete /api/brewery/:id' do
    context 'deleting a single brewery' do
      it 'deletes a single brewery by id' do
        delete '/api/brewery/3'

        expect(Beer.find_by_id(3)).to eq nil
      end
    end
  end
end
