require 'spec_helper'

describe ArticlesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      article = create(:article)
      get :edit, id: article
      expect(response).to be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      article = create(:article)
      get :edit, id: article
      expect(response).to be_success
    end
  end

end
