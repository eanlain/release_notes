require 'rails/generators/active_record'
require 'generators/release_notes/orm_helpers'

module ActiveRecord
  module Generators
    class ReleaseNotesGenerator < ActiveRecord::Generators::Base
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      include ReleaseNotes::Generators::OrmHelpers
      source_root File.expand_path("../templates", __FILE__)

      def copy_release_notes_migration
        if (behavior == :invoke && model_exists?)
          raise "#{table_name} already exists..."
        else
          migration_template "migration.rb", "db/migrate/release_notes_create_#{table_name}"
        end
      end

      def generate_model
        invoke "active_record:model", [name], :migration => false unless model_exists? && behavior == :invoke
      end

      def inject_release_notes_content
        content = model_contents

        class_path = if namespaced?
          class_name.to_s.split("::")
        else
          [class_name]
        end

        indent_depth = class_path.size - 1
        content = content.split("\n").map { |line| " " * indent_depth + line }.join("\n") << "\n"
      
        inject_into_class(model_path, class_path.last, content) if model_exists?
      end

      def migration_data
<<RUBY
      t.text :markdown,     :null => false
      t.string :version,    :null => false
RUBY
      end
    end
  end
end