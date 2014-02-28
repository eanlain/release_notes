### <% if @release_note_version.nil? -%><%= @subject -%><% else -%>[<%= @subject -%>](/<%= ReleaseNotes.mount_at -%>/<%= @release_note_version -%>)<% end -%>

<%= @body -%>