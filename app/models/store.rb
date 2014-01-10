class Store < ActiveRecord::Base
  validates_presence_of :name, :address
  validates_length_of :name, maximum: 50
  validates_length_of :address, maximum: 80

  has_many :articles, dependent: :destroy
end
