if ENV['SENTRY_DSN'].present?

  Raven::Configuration::IGNORE_DEFAULT = []

  Raven.configure do |config|
    config.dsn = ENV['SENTRY_DSN']
  end
end
