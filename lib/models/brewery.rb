require 'active_record'

class Brewery < ActiveRecord::Base
  validates :name, :location, presence: true
  has_many :beers
end
