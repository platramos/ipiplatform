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
    session[:userinfo] = request.env['omniauth.auth']
    user = User.find_by_email(session[:userinfo].uid)
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in!'
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    session[:userinfo] = nil
    redirect_to "https://thoughtworks.oktapreview.com/login/signout?fromURI=#{ENV['URL']}"
    #redirect_to root_url, notice: "Logged out!"
  end
end
