require 'rails'

module ReleaseNotes
  # Name of application using ReleaseNotes.
  mattr_accessor :app_name
  @@app_name = 'AppNameGoesHere'

  # Version to start ReleaseNotes if there are none.
  mattr_accessor :starting_version
  @@starting_version = '0.1.0'

  # Model name of the model created to store release notes.
  mattr_accessor :release_note_model
  @@release_note_model = 'ReleaseNote'

  # Model name of the model created to store users.
  mattr_accessor :user_model
  @@user_model = 'User'

  # Name of the folder where release notes are stored.
  mattr_accessor :release_note_folder
  @@release_note_folder = 'release_notes'

  # Path that ReleaseNotes::Engine is mounted at in the config/routes.rb file.
  mattr_accessor :mount_at
  @@mount_at = 'release_notes'

  # Default way to setup ReleaseNotes. Run rails g release_notes:install
  # to create a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end

require 'release_notes/engine'