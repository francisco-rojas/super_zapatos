# see https://gist.github.com/mattconnolly/4158961
module AuthenticationHelper
  def http_basic_login
    @env ||= {}
    user = ENV['API_USER']
    password = ENV['API_PASSWORD']
    @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,password)
  end
end

# Optionally
# describe "GET 'index'" do
  # it "should be successful" do
    # @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("username:password")
    # get 'index'
    # response.should be_success
  # end
# end