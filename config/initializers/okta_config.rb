require 'yaml'
OKTA_CONFIG = YAML.load_file(Rails.root.join("config", 'okta_config.yml'))

