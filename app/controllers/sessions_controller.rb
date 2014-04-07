class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_action :redirect_if_not_authorized_by_okta

  def new
  end

  def success

#  auth_hash = request.env['omniauth.auth']

#  @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
#  if @authorization
#    session[:userinfo] = auth_hash
#    redirect_to root_path
#  else
#    user = User.new :name => auth_hash["user_info"]["name"], :email => auth_hash["user_info"]["email"]
#    user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
#    user.save

#    redirect_to root_path
#  end


    session[:userinfo] = request.env['omniauth.auth']
    redirect_to root_path
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to session[:previous_url] || root_path, notice: 'Logged in!'
    else
      redirect_to new_session_path, notice: 'Invalid username or password.'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:userinfo].uid = nil
    redirect_to "https://thoughtworks.oktapreview.com/login/signout?fromURI=#{ENV['URL']}"
    #redirect_to root_url, notice: "Logged out!"
  end
end
