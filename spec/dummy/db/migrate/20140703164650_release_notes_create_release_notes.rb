class ReleaseNotesCreateReleaseNotes < ActiveRecord::Migration
  def change
    create_table(:release_notes) do |t|
      t.text :markdown,     :null => false
      t.string :version,    :null => false


      t.timestamps
    end

    add_index :release_notes, :version, :unique => true
  end
end