class OmniauthController < ApplicationController
    skip_before_filter :verify_authenticity_token
  def success
  end
end
