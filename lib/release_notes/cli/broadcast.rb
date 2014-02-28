module ReleaseNotes
  class Broadcast < Thor
    desc 'broadcast new', 'Create a new broadcast'
    method_option :destination, :aliases => '-d', :default => ReleaseNotes.release_note_folder, :desc => 'relative location of release note folder'
    method_option :release_note_version, :aliases => '-r', :desc => 'corresponding release note version'
    method_option :subject, :aliases => '-s', :default => "New Update", :desc => 'subject of broadcast'
    method_option :body, :aliases => '-b', :default => "We've made some new changes - check 'em out!", :desc => 'body of broadcast'

    def new
      release_note_version = options[:release_note_version] || ""

      ReleaseNotes::Generators::Broadcast.start([options[:destination],
                                                 options[:subject],
                                                 options[:body],
                                                 release_note_version])
    end


    desc 'broadcast set_version [VERSION]', 'Sets the latest broadcast to the given version'

    def set_version(version)
      rn = ReleaseNotes.broadcast_model.constantize.find_by(version: version)
      
      new_rn = ReleaseNotes.broadcast_model.constantize.new
      new_rn.version = rn.version
      new_rn.markdown = rn.markdown

      rn.destroy
      new_rn.save

      say "Latest broadcast is now set to version #{version}.", :green
    rescue NoMethodError
      say "Broadcast version #{version} was not found in the db.", :red
    end


    desc 'broadcast update', "Update #{ReleaseNotes.broadcast_model} models"
    method_option :destination, :aliases => '-d', :default => ReleaseNotes.release_note_folder, :desc => 'relative location of release note folder'
    method_option :reset, :aliases => '-r', :type => :boolean, :default => false, :desc => 'delete all model entries and rebuilds them'
    method_option :version, :aliases => '-v', :desc => 'specific broadcast version to save/update'

    def update
      # If reset option is passed delete all broadcasts in model
      if options[:reset]
        ReleaseNotes.broadcast_model.constantize.all.each do |b|
          b.destroy
        end
      end

      if options[:version]
        version = options[:version]
        broadcast_file = single_broadcast_lookup_at(options[:destination], version)
        markdown = File.read("#{options[:destination]}/#{broadcast_file}")

        # If version is set check to see if its already in db or create new one
        if ReleaseNotes.broadcast_model.constantize.find_by(version: version)
          ReleaseNotes.broadcast_model.constantize
                      .find_by(version: version)
                      .update_attributes(markdown: markdown)

          say "#{ReleaseNotes.broadcast_model} model successfully updated.", :green
        else
          ReleaseNotes.broadcast_model.constantize.create(version: version,
                                                          markdown: markdown)

          say "#{ReleaseNotes.broadcast_model} model successfully saved.", :green
        end
      else
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

            say "#{ReleaseNotes.broadcast_model} version #{version} successfully saved.", :green
          end
        end
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

      def single_broadcast_lookup_at(dirname, version)
        File.basename(Dir.glob("#{dirname}/*_#{version}*.md")[0])
      end
  end
end