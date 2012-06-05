TMDB_CONFIG = YAML.load_file("#{Rails.root}/config/tmdb_config.yml")
Tmdb.api_key = TMDB_CONFIG['api_key'] 
Tmdb.default_language = TMDB_CONFIG['language'] 
