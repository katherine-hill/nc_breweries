require 'active_model_serializers'

class BrewerySerializer < ActiveModel::Serializer
  attributes :id, :name, :location
  has_many :beers
end
