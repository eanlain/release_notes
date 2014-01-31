module ReleaseNotes
  class ReleaseNotesController < ApplicationController
    def index
      @release_notes = "::#{ReleaseNotes.release_note_model}".constantize.all.order('-id')
    end

    def show
    end
  end
end