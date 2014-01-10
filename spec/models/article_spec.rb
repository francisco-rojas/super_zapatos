require 'spec_helper'

describe Article do

  before do
    @required_attributes = [:name, :price, :store_id]
    @model_attributes = [:name, :description, :price, :total_in_shelf, :total_in_vault, :store_id]
    @article = Article.new(name: "Super Boots", description: "Big shiny boots",
                           price: 127.43, total_in_shelf: 1, total_in_vault: 2, store_id: 99)
  end

  it "should respond to attributes" do
    @model_attributes.each do |attr|
      @article.should respond_to(attr)
    end
  end

  it "should be valid" do
    @article.should be_valid
  end

  it "should validate presence of required attributes" do
    @required_attributes.each do |attr|
      @article.send("#{attr}=", nil)
      @article.should_not be_valid
    end
  end

  it "should validate length of name" do
    @article.name = 'a' * 90
    @article.should_not be_valid
  end

  describe "model associations" do
    before do
      @article.store_id = nil
      @article.create_store(name: "Super Zapatos San Jose", address: "Somewhere in San Jose")
      @article.save
    end

    it "should have access to the associate model" do
      @article.store.name.equal?("Super Zapatos San Jose")
    end
  end
end