class OmniauthController < ApplicationController
    skip_before_filter :verify_authenticity_token
  def success
    session[:userinfo] = request.env['omniauth.auth']
    byebug
    redirect_to root_path
  end
end
