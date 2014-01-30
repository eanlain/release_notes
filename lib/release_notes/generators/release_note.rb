require 'thor/group'

module ReleaseNotes
  module Generators
    class ReleaseNote < Thor::Group
      include Thor::Actions

      argument :destination, :type => :string
      argument :message, :type => :hash
      argument :release_version, :type => :string

      class_option :force, :type => :boolean, :default => false

      source_root File.expand_path('../../../generators/templates', __FILE__)
      
      def set_local_assigns
        @app_name = ReleaseNotes.app_name
        @update_template = 'update_blank.md'
        @destination = File.expand_path(destination)
        @release_version = release_version.gsub('.', '_')
        @message = message

        message.each do |k,v|
          if v.length > 0
            @update_template = 'update.md'
            break
          end
        end
      end

      def create_update_file
        empty_directory(@destination)
      end

      def check_version
        destination = version_exists?(@destination, @release_version)

        if destination
          if options.force?
            remove_file(destination)
          else
            raise Thor::Error, 
<<-ERROR
    Another update was found using the version number #{@release_version.gsub('_', '.')}. 
    Use --force to remove the old update file and replace it.
ERROR
          end
        end
      end

      def copy_release_note
        update_number = next_update_number(destination)
        @filename = "#{destination}/#{update_number}_#{@release_version}.md"
        template(@update_template, @filename)
      end

      # def append_to_README
      #   contents = File.read(@filename)

      #   begin
      #     oldREADME = File.read("#{destination}/README.md")
      #     contents << "\n\n---\n\n#{oldREADME}"
      #     File.write("#{destination}/README.md", "#{contents}", mode: 'w')
      #   rescue Errno::ENOENT
      #     File.write("#{destination}/README.md", "#{contents}", mode: 'w')
      #   end
      # end

      protected
        def next_update_number(dirname)
          next_update_number = current_update_number(dirname) + 1
          [Time.now.utc.strftime('%Y%m%d%H%M%S'), '%.14d' % next_update_number].max
        end

        def current_update_number(dirname)
          update_lookup_at(dirname).collect do |file|
            File.basename(file).split('_').first.to_i
          end.max.to_i
        end

        def update_lookup_at(dirname)
          Dir.glob("#{dirname}/[0-9]*_*.md")
        end

        def version_exists?(dirname, file_name)
          update_lookup_at(dirname).grep(/\d+_#{file_name}.md$/).first
        end
    end
  end
end