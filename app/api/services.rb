module Services
  class API < Grape::API
    version 'v1', using: :header, vendor: 'super_zapatos'
    format :json

    http_basic do |username, password|
      { ENV['API_USER'] => ENV['API_PASSWORD'] }[username] == password
    end

    resource :stores do
      desc "Loads all the stores that are stored in the database."
      get '/' do
        store = Store.all
        {"stores" => store.as_json(:only => [:id, :address, :name]), "success" => true, "total_elements" => store.count}
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
            store_articles = Article.find_all_by_store_id(params[:id])
            {"articles" => store_articles.as_json(:methods => :store_name, :only => [:id,:description,:name,:price,:total_in_shelf,:total_in_vault]), "success" => true, "total_elements" => store_articles.count }
          else
            status(404)
            {"success" => false,"error_code" => 404, "error_msg"=> "Record not found"}
          end
        else
          status(400)
          {"success" => false,"error_code" => 400, "error_msg" => "Bad request"}
        end

      end
    end
  end
end