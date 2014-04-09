Before('@omniauth_test') do
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:saml] = {
    "provider"=>"saml",
    "uid"=>"xxx@xxx.com"
  }
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end
