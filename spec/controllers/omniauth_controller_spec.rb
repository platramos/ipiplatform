require 'spec_helper'

describe OmniauthController do

  describe "GET 'success'" do
    it "redirects to root path on succes" do
      get 'success'
      response.should redirect_to(root_path)
    end
  end

end
