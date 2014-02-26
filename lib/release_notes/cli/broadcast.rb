module ReleaseNotes
  class Broadcast < Thor
    desc 'new', 'Create a new broadcast'
    method_option :destination, :aliases => '-d', :default => ReleaseNotes.release_note_folder, :desc => 'relative location of release note folder'
    method_option :body, :aliases => '-b', :default => "We've made some new changes - check 'em out!", :desc => 'body of broadcast'
    method_option :subject, :aliases => '-s', :default => "New Update", :desc => 'subject of broadcast'
    method_option :release_note_version, :aliases => '-r', :desc => 'corresponding release note version'

    def new
      ReleaseNotes::Generators::Broadcast.start([options[:destination],
                                                 options[:subject],
                                                 options[:body],
                                                 options[:release_note_version]])
    end


    desc 'update', "Update #{ReleaseNotes.broadcast_model} models"
    method_option :destination, :aliases => '-d', :default => ReleaseNotes.release_note_folder, :desc => 'relative location of release note folder'
    method_option :reset, :aliases => '-r', :type => :boolean, :default => false, :desc => 'delete all model entries and rebuilds them'

    def update
      # If reset option is passed delete all broadcasts in model
      if options[:reset]
        ReleaseNotes.broadcast_model.constantize.all.each do |b|
          b.destroy
        end
      end

      # Gets last broadcast version from db
      last_broadcast = ReleaseNotes.broadcast_model.constantize.last

      if last_broadcast.nil?
        last_version = 0
      else
        last_version = last_broadcast.version.to_i
      end
      
      # Collects relevant files and saves version and content to db
      broadcast_files = collect_broadcast_files(options[:destination])
      broadcast_files.each do |file|
        version = file.split('_').last.to_i
        
        if version > last_version
          markdown = File.read("#{options[:destination]}/#{file}")

          ReleaseNotes.broadcast_model.constantize.create(version: version,
                                                          markdown: markdown)
        end
      end

      say "#{ReleaseNotes.broadcast_model} model successfully updated.", :green
    end


    desc 'users', "Update #{ReleaseNotes.user_broadcast_model} models"

    def users
      all_users = ReleaseNotes.user_model.constantize.all
      last_broadcast = ReleaseNotes.broadcast_model.constantize.last

      user_id_field = ReleaseNotes.user_broadcast_model.underscore.split('_').first()
      broadcast_id_field = ReleaseNotes.user_broadcast_model.underscore.split('_').last().singularize

      all_users.each do |u|
        ReleaseNotes.user_broadcast_model.constantize.create("#{user_id_field}_id".to_sym => u.id, "#{broadcast_id_field}_id".to_sym => last_broadcast.id)
      end
    end

    protected
      def collect_broadcast_files(dirname)
        broadcast_lookup_at(dirname).collect do |file|
          File.basename(file)
        end
      end

      def current_broadcast_number(dirname)
        broadcast_lookup_at(dirname).collect do |file|
          File.basename(file).split('_').last.to_i
        end.max.to_i
      end

      def broadcast_lookup_at(dirname)
        Dir.glob("#{dirname}/*_[0-9]*.md")
      end
  end
end