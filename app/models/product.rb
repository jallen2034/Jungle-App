# this is the model/class or abstractio layer where ruby can interact with our database to:
# When the AR is communicating with the database whenever a new product request is made
# this sublass has rules set in place to verify the model gets the input/data it needs to perform the 
# update to our db in order to work
class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

end
