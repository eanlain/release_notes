require 'thor'
require 'release_notes'
require 'release_notes/versioning'
require 'release_notes/cli/helpers'
require 'release_notes/generators/release_note'

module ReleaseNotes
  class CLI < Thor
  
    package_name 'ReleaseNotes'
    map '-v' => :version


    desc 'new', 'create a new release note'
    method_option :destination, :aliases => '-d', :default => 'release_notes', :desc => 'relative location of release note folder'
    method_option :force, :aliases => '-f',  :type => :boolean, :desc => 'overwrite files that already exist'
    method_option :increment, :aliases => '-i', :default => 'patch', :banner => 'MODE', :desc => 'increment version by mode'
    method_option :message, :aliases => '-m', :desc => 'interactive release note bullet input'
    method_option :version, :aliases => '-V', :desc => 'use the given version number'

    def new
      
      if options[:version].nil?
        last_version = ReleaseNotes::Versioning.current_version_number(options[:destination])
        update_version = ReleaseNotes::Versioning::Semantic.increment(last_version, options[:increment])
      else
        update_version = options[:version]
      end

      message = ReleaseNotes::CLI::Helpers.setup_message_obj

      if options[:message]
        message = ReleaseNotes::CLI::Helpers.interactive_bullets(message)        
      end

      ReleaseNotes::Generators::ReleaseNote.start([options[:destination],
                                             message,
                                             update_version,
                                             "--force=#{options[:force] || false}"])
    end


    desc 'update', 'update ReleaseNotes model'
    method_option :destination, :aliases => '-d', :default => 'release_notes', :desc => 'relative location of release note folder'
    method_option :model, :aliases => '-m', :default => 'ReleaseNote', :desc => 'model to update'
    method_option :reset, :aliases => '-r', :desc => 'deletes all model entries and rebuilds them'
    method_option :version, :aliases => '-V', :desc => 'updates only the given version number'

    def update
      # Look at folder...
      # Does a schema file exist?
      #   If so, mark as not nil and see what last timestamp is
      #   If not mark as nil
      # Collect current versions greater than timestamp or nil
      # For each version read file and run github markup to get html
      # Save HTML and Markdown in model
      # Also append to README (if any)
    end


    desc 'version', 'show version of release_notes'

    def version
      puts "ReleaseNotes #{ReleaseNotes::VERSION}"
    end
  end
end