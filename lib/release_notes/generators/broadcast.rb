require 'thor/group'

module ReleaseNotes
  module Generators
    class Broadcast < Thor::Group
      include Thor::Actions

      argument :destination, :type => :string
      argument :subject, :type => :string
      argument :body, :type => :string
      argument :release_note_version, :type => :string

      source_root File.expand_path('../../../generators/templates', __FILE__)

      def set_local_assigns
        @subject = subject
        @body = body

        if release_note_version != ""
          @release_note_version = release_note_version.gsub('.', '_')
        else
          @release_note_version = nil
        end
        
        @broadcast_template = 'broadcast_blank.md'
        @destination = File.expand_path(destination)
      end

      def create_directory
        empty_directory(@destination)
      end

      def get_broadcast_number
        @broadcast_number = next_broadcast_number(@destination)
      end

      def copy_broadcast
        @filename = "#{destination}/broadcast_#{@broadcast_number}.md"
        template(@broadcast_template, @filename)
      end

      protected
        def next_broadcast_number(dirname)
          current_broadcast_number(dirname) + 1
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
end