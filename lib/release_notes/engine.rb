module ReleaseNotes
  class Engine < ::Rails::Engine
    isolate_namespace ReleaseNotes

    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/release_notes/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end

    initializer 'release_notes.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper ReleaseNotes::ApplicationHelper
      end
    end
  end
end