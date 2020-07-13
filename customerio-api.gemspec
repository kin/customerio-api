Gem::Specification.new do |gem|
  gem.authors = ["Marco Cortes"]
  gem.name = "customerio-api"
  gem.version = "0.0.1"
  gem.summary = "A ruby client for the CustomerIO REST API."
  gem.homepage = "http://customer.io"
  gem.license = "MIT"
  gem.files = [
    'lib/customerio_api/client.rb',
    'lib/customerio_api.rb'
  ]
  gem.require_paths = ["lib"]
end
