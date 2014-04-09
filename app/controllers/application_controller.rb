class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :store_location
  before_action :redirect_if_not_authorized_by_okta

  def redirect_if_not_authorized_by_okta
    if !okta_user
      redirect_to '/auth/saml'
    end
  end

  def redirect_if_not_signed_in
    redirect_to new_session_path, notice: 'Please sign in!' and return if current_user.nil?
  end

  def redirect_if_unauthorized
    redirect_to root_path, notice: 'Not authorized!' and return unless current_user.present? && current_user.is_admin?
  end

  def store_location
    if (request.fullpath != "/users/new" &&
      request.fullpath != "/sessions/new" &&
      request.fullpath != "/sessions" &&
      !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def okta_user
    @okta_user = session[:userinfo]
  end
  helper_method :current_user
end
