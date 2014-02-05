require 'rails/generators/named_base'

module ReleaseNotes
  module Generators
    class ReleaseNotesGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      namespace "release_notes"
      source_root File.expand_path("../templates", __FILE__)

      desc "Generates a ReleaseNote model with the given NAME (if one does not exist) with " <<
           "release_notes configuration plus release_notes routes."

      hook_for :orm

      class_option :routes, :desc => "Generate routes", :type => :boolean, :default => true

      def add_release_notes_routes
        release_notes_routes = "mount ReleaseNotes::Engine, at: '/#{plural_name}', :as => '#{ReleaseNotes.mount_at}'"

        route release_notes_routes
      end
    end
  end
end