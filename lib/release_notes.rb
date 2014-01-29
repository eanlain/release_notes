require 'rails'

module ReleaseNotes
  mattr_accessor :app_name
  @@app_name = "AppNameGoesHere"

  mattr_accessor :starting_version
  @@starting_version = "0.1.0"
end
