require 'spec_helper'

describe OmniauthController do

  describe "GET 'success'" do
    it "returns http success" do
      get 'success'
      response.should be_success
    end
  end

end
