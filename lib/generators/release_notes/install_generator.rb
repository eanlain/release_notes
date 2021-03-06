require 'rails/generators/base'

module ReleaseNotes
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a ReleaseNotes initializer for your application."

      class_option :orm

      def copy_initializer
        template "release_notes.rb", "config/initializers/release_notes.rb"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end