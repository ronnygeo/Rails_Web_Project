class Event < ActiveRecord::Base
  belongs_to :client
  has_many :subcategorizations
  has_many :subcategories, through: :subcategorizations
  has_one :payment
  has_many :reviews
end
