ReleaseNotes::Engine.routes.draw do
  # resources :resource_notes, only: [:index, :show]
  root :to => "release_notes#index"
end
