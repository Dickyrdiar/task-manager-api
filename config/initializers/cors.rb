# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors
null_regex = Regexp.new(/\Anull\z/)

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    hostnames = [null_regex, 'localhost:4200', 'app.forestadmin.com', 'localhost:3001']
    hostnames += ENV['CORS_ORIGINS'].split(',') if ENV['CORS_ORIGINS']

    origins hostnames
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: %w[pages_count Content-Disposition],
      credentials: true
  end
end
