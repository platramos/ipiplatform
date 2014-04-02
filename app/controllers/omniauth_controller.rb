class OmniauthController < ApplicationController
    skip_before_filter :verify_authenticity_token
  def success
    redirect_to root_path
  end
end
