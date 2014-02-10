module ReleaseNotes
  class ReleaseNotesController < ApplicationController
    layout "release_notes/application"
    
    def index
      @release_notes = "::#{ReleaseNotes.release_note_model}".constantize.all.order('-id')
    end

    def show
      @release_notes = "::#{ReleaseNotes.release_note_model}".constantize.where(version: "#{params[:version]}".gsub('_','.'))
    end
  end
end