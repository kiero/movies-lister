# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MoviesLister::Application.initialize!

AUTH_CONFIG = YAML.load_file("#{Rails.root}/config/authentication.yml")
