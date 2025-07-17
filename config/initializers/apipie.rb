Apipie.configure do |config|
  config.app_name                = "shop-it"
  config.api_base_url            = ""
  config.doc_base_url            = "/apipie-docs"
  config.translate               = false
  config.validate                = false
  config.namespaced_resources    = true
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
