module ReleaseNotes
  class Engine < ::Rails::Engine
    require 'bootstrap-sass'
    
    isolate_namespace ReleaseNotes

    config.generators do |g|
      g.test_framework        :rspec
      g.fixture_replacement   :factory_girl, :dir => 'spec/factories'
    end

    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/release_notes/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end

    initializer 'release_notes.precompile_hook' do |app|
      app.config.assets.precompile += %w[
        release_notes/bootstrap.js
      ]
    end

    initializer 'release_notes.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper ReleaseNotes::ApplicationHelper
      end
    end
  end
end