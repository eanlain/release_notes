module ReleaseNotes
  class Engine < ::Rails::Engine
    require 'bootstrap-sass'
    
    isolate_namespace ReleaseNotes

    config.generators do |g|
      g.test_framework        :rspec
      g.fixture_replacement   :factory_girl, :dir => 'spec/factories'
    end

    initializer 'release_notes.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper ReleaseNotes::ApplicationHelper
      end
    end
  end
end