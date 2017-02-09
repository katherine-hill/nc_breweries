require 'active_record'

class Beer < ActiveRecord::Base
  validates :name, :description, presence: true
  validates :kind, :rating, numericality: { only_integer: true, greater_than: 0 }
  belongs_to :brewery
end
