class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_action :redirect_if_not_authorized_by_okta

  def new
  end

  def success
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
    session[:userinfo] = nil
    redirect_to "https://thoughtworks.oktapreview.com/login/signout?fromURI=#{ENV['URL']}"
  end
end
