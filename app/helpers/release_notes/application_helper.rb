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

      render_options = [:filter_html => true,
                        :hard_wrap => true,
                        :prettify => true]

      renderer = Redcarpet::Render::HTML.new(*render_options)
      mark = Redcarpet::Markdown.new(renderer, *extension_options)

      mark.render(markdown)
    end
  end
end