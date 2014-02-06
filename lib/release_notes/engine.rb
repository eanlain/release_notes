module ReleaseNotes
  class Engine < ::Rails::Engine
    isolate_namespace ReleaseNotes

    initializer 'release_notes.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper ReleaseNotes::ApplicationHelper
      end
    end
  end
end