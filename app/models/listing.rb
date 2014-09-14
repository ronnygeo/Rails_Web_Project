class Listing < ActiveRecord::Base
  belongs_to :client
  has_many :subcategorizations
  has_many :subcategories, through: :subcategorizations
  has_one :payment
  has_many :reviews

  has_many :images, as: :imageable
  has_many :socials, as: :socialize

  searchkick

  scope :ofsubcategory, ->(subcat){ where(client.subcategory == subcat.to_s) }

end
