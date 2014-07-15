require 'aruba/cucumber'
require 'pry'
require 'rails'

Before do
  @aruba_timeout_seconds = 20
  @dirs = ["tmp"]
end
