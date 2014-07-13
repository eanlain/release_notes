require 'rails_helper'

describe "routing to release_notes" do
  routes { ReleaseNotes::Engine.routes }

  it "routes /release_notes to release_notes#index" do
    expect(:get => "/").to route_to(
      :controller => "release_notes/release_notes",
      :action => "index"
    )
  end

  it "routes /release_notes/:version to release_notes#show" do
    expect(:get => "/:version").to route_to(
      :controller => "release_notes/release_notes",
      :action => "show",
      :version => ":version"
    )
  end
end