module ReleaseNotes
  module Generators
    module OrmHelpers
      def release_notes_model_contents
        buffer = <<-CONTENT
  validates :version, presence: true, uniqueness: true
CONTENT
        buffer
      end

      def broadcasts_model_contents
        buffer = <<-CONTENT
  validates :message, presence: true
  validates :version, presence: true, uniqueness: true
CONTENT
        buffer
      end

      private

        def model_exists?
          File.exists?(File.join(destination_root, model_path))
        end
        
        def migration_path
          @migration_path ||= File.join("db", "migrate")
        end

        def model_path
          @model_path ||= File.join("app", "models", "#{file_path}.rb")
        end
    end
  end
end