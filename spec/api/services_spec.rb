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

  describe "Unsuccessful requests" do
    it 'should return a bad request error' do
      http_basic_login
      error_msg = '{"success":false,"error_code":400,"error_msg":"Bad request"}'

      get "/services/articles/stores/W", {}, @env
      expect(response.status).to eql(400)
      expect(response.body).to eql(error_msg)
    end

    it 'should return a Record not found error' do
      http_basic_login
      error_msg = '{"success":false,"error_code":404,"error_msg":"Record not found"}'

      get "/services/articles/stores/99", {}, @env
      expect(response.status).to eql(404)
      expect(response.body).to eql(error_msg)
    end

    it 'should return a Not authorized error' do
      error_msg = '{"success":false,"error_code": 401, "error_msg":"Not authorized"}'

      get "/services/articles", {}, @env
      expect(response.status).to eql(401)
      expect(response.body).to eql(error_msg)
    end

    it 'should return a Server Error error' do
      http_basic_login
      error_msg = '{"success":false,"error_code": 500, "error_msg":"Server error"}'

      get "/services/articles", {}, @env
      expect(response.status).to eql(500)
      expect(response.body).to eql(error_msg)
    end
  end
end


