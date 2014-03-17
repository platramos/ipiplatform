Rails.application.config.middleware.use OmniAuth::Builder do
    provider :saml,
       :assertion_consumer_service_url     => "ipiplatform.herokuapp.com/auth/saml/callback/",
       :issuer                             => "rails-application",
       :idp_sso_target_url                 => "idp_sso_target_url",
       :idp_cert                           => "-----BEGIN CERTIFICATE-----\n...-----END CERTIFICATE-----",
       :name_identifier_format             => "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
end
