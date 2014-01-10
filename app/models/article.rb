class Article < ActiveRecord::Base
  validates_presence_of :name, :price, :store_id
  validates_length_of :name, maximum: 50

  belongs_to :store
end
