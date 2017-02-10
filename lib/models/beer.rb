require 'active_record'

class Beer < ActiveRecord::Base
  validates :name, presence: true # TODO: :kind, :description, ?
  validates :rating, numericality: { only_integer: true, greater_than: -1 }
  belongs_to :brewery
end
