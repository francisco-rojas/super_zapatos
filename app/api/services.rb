require 'grape'

module Services
  class API < Grape::API
    version 'v1', using: :accept_version_header

    content_type :xml, 'application/xml'
    content_type :json, 'application/json'
    default_format :json
    format :json

    rescue_from :all do |e|
      if e.message == "Authentication error"
        Rack::Response.new({'success' => false,'error_code' => 401,'error_msg' => 'Not authorized'}.to_json, 401)
      else
        Rack::Response.new({'success' => false,'error_code' => 500,'error_msg' => 'Server error'}.to_json, 500)
      end
    end

    http_basic do |username, password|
      # raise("Authentication error") unless { 'my_user' => 'my_password' }[username] == password
      { 'my_user' => 'my_password' }[username] == password
    end

    error_400 = {"success" => false,"error_code" => 400,"error_msg" => "Bad request"}
    error_404 = {"success" => false,"error_code" => 404,"error_msg" =>"Record not found"}

    resource :stores do
      desc "Loads all the stores that are stored in the database."
      get '/' do
        stores = Store.all
        {"stores" => stores.as_json(:only => [:id, :address, :name]), "success" => true, "total_elements" => stores.count}
      end
    end

    resource 'articles' do
      desc "Loads all the articles that are in the database."
      get '/' do
        articles = Article.all
        {"articles" => articles.as_json(:methods => :store_name, :only => [:id,:description,:name,:price,:total_in_shelf,:total_in_vault]), "success" => true, "total_elements" => articles.count }
      end

      desc "Loads all the articles from a specific store that are in the database."
      get '/stores/:id' do
        if params[:id].to_i.to_s == params[:id]
          if Store.exists?(params[:id])
            store_articles = Store.find(params[:id]).articles
            {"articles" => store_articles.as_json(:methods => :store_name, :only => [:id,:description,:name,:price,:total_in_shelf,:total_in_vault]), "success" => true, "total_elements" => store_articles.count }
          else
            error!(error_404, 404)
          end
        else
          error!(error_400, 400)
        end
      end
    end

    route :any, '*path' do
      error!(error_400, 400)
    end
  end
end