class Article < ActiveRecord::Base
  validates_presence_of :name, :price, :store_id
  validates_length_of :name, maximum: 50

  belongs_to :store

  def store_name
    @store_name = Store.find(self.store_id).name
  end
end
