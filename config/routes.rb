ReleaseNotes::Engine.routes.draw do
  get '/' => 'release_notes#index'
  get '/:version' => 'release_notes#show', as: 'version'
end
