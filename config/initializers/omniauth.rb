require 'yaml'
OKTA_CONFIG = YAML.load_file(Rails.root.join("config", 'okta_config.yml'))
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :saml,
       issuer:                             OKTA_CONFIG['issuer'],
       idp_sso_target_url:                 OKTA_CONFIG['idp_sso_target_url'],
       idp_cert:                           OKTA_CONFIG['idp_cert'],
       idp_sso_target_url_runtim_params:  {:redirectUrl => :RelayState}
end
