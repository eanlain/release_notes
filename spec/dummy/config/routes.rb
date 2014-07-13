Rails.application.routes.draw do
  root to: "home#index"

  mount ReleaseNotes::Engine, at: '/release_notes', :as => 'release_notes'
end
