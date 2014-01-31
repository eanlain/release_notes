# Use this hook to configure ReleaseNotes.
ReleaseNotes.setup do |config|
  # The name of your application.
  config.app_name = 'AppNameGoesHere'

  # The name of the model you're using to store the various release notes.
  config.release_note_model = 'ReleaseNote'

  # The name of the folder you're using to store the release note markdown files.
  config.release_note_folder = 'release_notes'

  # The version number that the first ReleaseNote should start at.
  config.starting_version = '0.1.0'
end