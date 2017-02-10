require 'active_record'
require_relative '../serializers/brewery_serializer'

class Brewery < ActiveRecord::Base
  validates :name, :location, presence: true
  has_many :beers

  def active_model_serializer
    BrewerySerializer
  end
end
