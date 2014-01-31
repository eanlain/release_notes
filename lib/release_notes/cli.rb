require 'thor'
require 'github/markup'
require 'release_notes'
require 'release_notes/versioning'
require 'release_notes/cli/helpers'
require 'release_notes/generators/release_note'

module ReleaseNotes
  class CLI < Thor
    
    package_name 'ReleaseNotes'
    map '-v' => :version


    desc 'new', 'create a new release note'
    method_option :destination, :aliases => '-d', :default => ReleaseNotes.release_note_folder, :desc => 'relative location of release note folder'
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


    desc 'update', "update #{ReleaseNotes.release_note_model} model"
    method_option :destination, :aliases => '-d', :default => ReleaseNotes.release_note_folder, :desc => 'relative location of release note folder'
    method_option :no_log, :aliases => '-n', :type => :boolean, :default => false, :desc => 'disable README.md log of release notes'
    method_option :reset, :aliases => '-r', :type => :boolean, :default => false, :desc => 'delete all model entries and rebuilds them'
    # method_option :version, :aliases => '-V', :desc => 'update only the given version number'

    def update
      # If reset option is passed delete all release notes in model
      if options[:reset]
        stamp = nil
        release_log = ""

        begin
          File.delete("#{options[:destination]}/README.md")
        rescue Errno::ENOENT
          # Nothing to see here... move along.
        end

        ReleaseNotes.release_note_model.constantize.all.each do |rn|
          rn.destroy
        end
      else
        # Checks timestamp of last release note stored
        begin
          stamp = File.read("#{options[:destination]}/stamp")
        rescue Errno::ENOENT
          stamp = nil
        end

        # Reads contents of release note compilation file
        begin
          release_log = File.read("#{options[:destination]}/README.md")
        rescue Errno::ENOENT
          release_log = ""
        end
      end

      # Collects relevant files and saves version and content to db
      update_files = collect_update_files(options[:destination])
      update_files.each do |file|
        timestamp = file[0].to_i

        if !stamp.nil? and timestamp <= stamp.to_i
          next
        end 

        version = file[1..4].join('.')[0..-4]

        file = file.join('_')
        markdown = File.read("#{options[:destination]}/#{file}")
        ReleaseNotes.release_note_model.constantize.create(version: version,
                                                           markdown: markdown)

        release_log.insert(0, "#{markdown}\n\n---\n\n") unless options[:no_log]
      end

      # Store the timestamp of the last release note
      new_stamp = latest_update_file(options[:destination])
      File.write("#{options[:destination]}/stamp", "#{new_stamp}", mode: 'w')

      # Store release note compilation file
      File.write("#{options[:destination]}/README.md", "#{release_log}", mode: 'w') unless options[:no_log]

      say "#{ReleaseNotes.release_note_model} model successfully updated.", :green
      say "ReleaseNotes log successfully updated (see #{options[:destination]}/README.md).", :green unless options[:no_log]
    end


    desc 'version', 'show version of release_notes'

    def version
      puts "ReleaseNotes #{ReleaseNotes::VERSION}"
    end


    protected
      def collect_update_files(dirname)
        update_lookup_at(dirname).collect do |file|
          File.basename(file).split('_')
        end
      end

      def latest_update_file(dirname)
        update_lookup_at(dirname).collect do |file|
          File.basename(file).split('_').first.to_i
        end.max.to_i
      end

      def update_lookup_at(dirname)
        Dir.glob("#{dirname}/[0-9]*_*.md")
      end
  end
end