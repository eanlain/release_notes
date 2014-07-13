module ReleaseNotes
  module ApplicationHelper
    require 'redcarpet'
    
    def markup(markdown)
      extension_options = [:no_intra_emphasis => true,
                           :tables => true,
                           :fenced_code_blocks => true,
                           :autolink => true,
                           :strikethrough => true,
                           :space_after_headers => true,
                           :superscript => true,
                           :underline => true,
                           :highlight => true,
                           :quote => true,
                           :footnotes => true]

      render_options = [:filter_html => false,
                        :hard_wrap => true,
                        :prettify => true]

      renderer = Redcarpet::Render::HTML.new(*render_options)
      mark = Redcarpet::Markdown.new(renderer, *extension_options)

      mark.render(markdown)
    end

    def release_note_indicator
      latest = ReleaseNotes.release_note_model.constantize.last
      
      link_to "#{ReleaseNotes.app_name} v#{latest.version}", release_notes.version_path(:version => latest.version.gsub('.','_')), 'data-no-turbolink' => true unless latest.nil?
    end
  end
end