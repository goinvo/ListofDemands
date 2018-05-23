require 'flipper'

Flipper.configure do |config|
  config.default do
    adapter = Flipper::Adapters::ActiveRecord.new
    
    # pass adapter to handy DSL instance
    Flipper.new(adapter)
  end
end
