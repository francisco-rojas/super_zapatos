require 'spec_helper'

describe Store do

  before do
    @required_attributes = [:name, :address]
    @store = build(:store)
  end

  it "should respond to attributes" do
    @required_attributes.each do |attr|
      @store.should respond_to(attr)
    end
  end

  it "should be valid" do
    @store.should be_valid
  end

  it "should validate presence of required attributes" do
    @required_attributes.each do |attr|
      @store.send("#{attr}=", nil)
      @store.should_not be_valid
    end
  end

  it "should validate length of the required attributes" do
    @required_attributes.each do |attr|
      @store.send("#{attr}=", 'a' * 90)
      @store.should_not be_valid
    end
  end

  describe "model associations" do
    before do
      @store.save
      @store.articles.create(name: "Super Tennis", description: "Addidas shoes",
                             price: 89.43, total_in_shelf: 1, total_in_vault: 2)
    end

    it "should have access to the associate model" do
      @store.articles.first.store_id.eql?(@store.id)
    end
  end
end
