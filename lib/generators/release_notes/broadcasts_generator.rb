require 'rails/generators/named_base'

module ReleaseNotes
  module Generators
    class BroadcastsGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      namespace "release_notes:broadcasts"
      source_root File.expand_path("../templates", __FILE__)

      desc "Generates a Broadcast model with the given NAME (if one does not exist)."

      hook_for :orm
    end
  end
end