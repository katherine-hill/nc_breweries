require_relative '../lib/resources/beer'
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

  describe Beer do
    describe '#valid?' do
      context 'when only given a name' do
        it 'returns false' do
          beer = Beer.new(name: 'High Life')

          expect(beer.valid?).to eq false
        end
      end
      context 'when only given a kind' do
        it 'returns false' do
          beer = Beer.new(kind: 5)

          expect(beer.valid?).to eq false
        end
      end
      context 'when only given a description' do
        it 'returns false' do
          beer = Beer.new(description: 'Blue collar refined flavor')

          expect(beer.valid?).to eq false
        end
      end
      context 'when only given a rating' do
        it 'returns false' do
          beer = Beer.new(rating: 3)

          expect(beer.valid?).to eq false
        end
      end
      context 'when only given a brewery_id' do
        it 'returns false' do
          beer = Beer.new(brewery_id: 1)

          expect(beer.valid?).to eq false
        end
      end
      context 'when given all required parameters' do
        it 'returns true' do
          beer = Beer.new(name: 'High Life', kind: 5, description: 'Blue collar refined flavor', rating: 3, brewery_id: 1)

          expect(beer.valid?).to eq true
        end
      end
    end
  end

#  ______     ______   __
# /\  __ \   /\  == \ /\ \
# \ \  __ \  \ \  _-/ \ \ \
#  \ \_\ \_\  \ \_\    \ \_\
#   \/_/\/_/   \/_/     \/_/

  describe 'API #get /api/beer' do
    context 'calling all beers' do
      it 'returns all beers' do
        get '/api/beer'
          # binding.pry
        expect(last_response).to be_ok
        # expect(last_response.body).to include('High Life')
        expect(last_response.status).to eq 200
      end
    end
  end
end
