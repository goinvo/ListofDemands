Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:8000', 'https://www.goinvo.com'
    resource '*', headers: :any, methods: [:get]
  end
end
