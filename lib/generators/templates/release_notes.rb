# Use this hook to configure ReleaseNotes.
ReleaseNotes.setup do |config|
  # Name of your application.
  config.app_name = 'Application Name Goes Here'

  # Name of the model you're using to store the various release notes.
  config.release_note_model = 'ReleaseNote'

  # Name of the folder you're using to store the release note markdown files.
  config.release_note_folder = 'release_notes'

  # Path that ReleaseNotes::Engine is mounted at in the config/routes.rb file.
  config.mount_at = 'release_notes'

  # Version number that the first ReleaseNote should start at.
  config.starting_version = '0.1.0'
end