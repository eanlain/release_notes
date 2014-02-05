require 'rails/generators/active_record'
require 'generators/release_notes/orm_helpers'

module ActiveRecord
  module Generators
    class BroadcastsGenerator < ActiveRecord::Generators::Base
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      include ReleaseNotes::Generators::OrmHelpers
      source_root File.expand_path("../templates", __FILE__)

      def copy_broadcasts_migration
        if (behavior == :invoke && model_exists?)
          raise "#{table_name} already exists..."
        else
          migration_template "broadcasts_migration.rb", "db/migrate/release_notes_create_#{table_name}"
        end
      end

      def generate_module
        invoke "active_record:model", [name], :migration => false unless model_exists? && behavior == :invoke
      end

      def inject_broadcasts_content
        content = broadcasts_model_contents

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
