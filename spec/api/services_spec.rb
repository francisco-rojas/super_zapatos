require 'spec_helper'

describe Services::API do

  describe "successful requests" do
    before do
      http_basic_login
      @store = create(:store)
      @article = create(:article)
      @total_stores = Store.all.size
      @total_articles = Article.all.size
    end

    describe "GET /services/stores" do
      it "returns all stores in json format" do
        stores_as_json = %Q({"stores":[{"id":#{@store.id},"name":"#{@store.name}","address":"#{@store.address}"}],"success":true,"total_elements":#{@total_stores}})
        get "/services/stores", {}, @env
        expect(response.status).to eql(200)
        expect(response.body).to eql(stores_as_json)
      end
    end

    describe "GET /services/articles" do
      it "returns all articles in json format" do
        articles_as_json = %Q({"articles":[{"id":#{@article.id},"name":"#{@article.name}","description":"#{@article.description}","price":#{@article.price},"total_in_shelf":#{@article.total_in_shelf},"total_in_vault":#{@article.total_in_vault},"store_name":"#{@article.store_name}"}],"success":true,"total_elements":#{@total_articles}})
        get "/services/articles", {}, @env
        expect(response.status).to eql(200)
        expect(response.body).to eql(articles_as_json)
      end
    end

    describe "GET /services/articles/stores/:id" do
      it "should return all articles that belong to a specific store" do
        articles_as_json = %Q({"articles":[{"id":#{@article.id},"name":"#{@article.name}","description":"#{@article.description}","price":#{@article.price},"total_in_shelf":#{@article.total_in_shelf},"total_in_vault":#{@article.total_in_vault},"store_name":"#{@article.store_name}"}],"success":true,"total_elements":#{@article.store.articles.size}})
        get "/services/articles/stores/#{@article.store_id}", {}, @env
        expect(response.status).to eql(200)
        expect(response.body).to eql(articles_as_json)
      end
    end
  end

  describe "Request errors" do

    describe "bad request errors" do
      before do
        http_basic_login
      end
      @wrong_requests = ["/services/articles/W", "/services/stores/W", "/services/articles/stores/W"]
      it 'should return a 400 error' do
        @wrong_requests.each do |url|
          get url, {}, @env
        end
      end
    end

    it 'should return a Not authorized error' do
    end

    it 'should return a Record not found error' do
    end

    it 'should return a Server Error error' do
    end
  end
end


