require 'rails/generators/active_record'
require 'generators/release_notes/orm_helpers'

module ActiveRecord
  module Generators
    class UserBroadcastsGenerator < ActiveRecord::Generators::Base
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      include ReleaseNotes::Generators::OrmHelpers
      source_root File.expand_path("../templates", __FILE__)

      def copy_user_broadcasts_migration
        if (behavior == :invoke && model_exists?)
          raise "#{table_name} already exists..."
        else
          migration_template "user_broadcasts_migration.rb", "db/migrate/release_notes_create_#{table_name}"
        end
      end

      def generate_module
        invoke "active_record:model", [name], :migration => false unless model_exists? && behavior == :invoke
      end

      def migration_data
<<RUBY
      t.integer :#{table_name.underscore.split('_').first()}_id,      :null => false
      t.integer :#{table_name.underscore.split('_').last().singularize}_id,     :null => false
RUBY
      end
    end
  end
end