require 'spec_helper'

describe SessionsController do
  before(:each) do
    OmniAuth.config.test_mode = true
    @user = FactoryGirl.create(:user)
    omniauth_hash = { provider: 'saml', uid: @user.email }
    OmniAuth.config.add_mock(:saml, omniauth_hash)
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:saml]
  end

  describe '#create' do
    before :each do
      session[:userinfo] = request.env['omniauth.auth']
      @user_params = { email: @user.email, password: @user.password }
      User.stub(:find_by_email).with(session[:userinfo].uid).and_return(@user)
      #User.any_instance.stub(:authenticate).and_return(true)
    end


    context 'as the first site interaction' do
      it 'should redirect the user to the homepage' do
        get :new

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(new_session_path)

        get :create, @user_params

        expect(response.status).to be(302)
        response.should redirect_to(root_path)
      end
    end

    context 'after viewing homepage' do
      it 'should redirect the user to the homepage' do
        session[:previous_url] = '/'

        get :new

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(new_session_path)

        get :create, @user_params

        expect(response.status).to be(302)
        response.should redirect_to(root_path)
      end
    end

    context 'after trying to view resources' do
      it 'should redirect the user to the resources page' do
        session[:previous_url] = '/resources/'

        get :new

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(new_session_path)

        get :create, @user_params

        expect(response.status).to be(302)
        response.should redirect_to(resources_path + '/')
      end
    end
  end
end
