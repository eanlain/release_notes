require 'rails'

module ReleaseNotes
  # Name of application using ReleaseNotes.
  mattr_accessor :app_name
  @@app_name = 'AppNameGoesHere'

  # Version to start ReleaseNotes if there are none.
  mattr_accessor :starting_version
  @@starting_version = '0.1.0'

  # Model name of the model created to store ReleaseNotes.
  mattr_accessor :release_note_model
  @@release_note_model = 'ReleaseNote'

  # Default way to setup ReleaseNotes. Run rails g release_notes:install
  # to create a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end

require 'release_notes/engine'