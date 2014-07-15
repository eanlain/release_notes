require 'rails_helper'

module ReleaseNotes
  RSpec.describe ReleaseNotesController, :type => :controller do

    describe "#index" do
      it "responds with an HTTP 200 status code" do
        get :index, { use_route: :release_notes }

        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders 'index' html template" do
        get :index, { use_route: :release_notes }

        expect(response).to render_template(:index)
      end

      it "assigns @release_notes" do
        @release_notes = FactoryGirl.create_list(:release_note, 3)

        get :index, { use_route: :release_notes }

        expect(assigns(:release_notes).count).to eq(3)
        expect(assigns(:release_notes)).to eq(@release_notes.reverse)
      end
    end

    describe "#show" do
      before(:each) do
        @release_note = FactoryGirl.create(:release_note)
      end

      it "responds with an HTTP 200 status code" do
        get :show, { version: @release_note.version, use_route: :release_notes }

        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders 'show' html template" do
        get :show, { version: @release_note.version, use_route: :release_notes }

        expect(response).to render_template(:show)
      end

      it "assigns @release_notes" do
        get :show, { version: @release_note.version, use_route: :release_notes }

        expect(assigns(:release_notes)).to eq([@release_note])
      end
    end
  end
end