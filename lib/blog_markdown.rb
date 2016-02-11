require 'action_view/helpers'

class BlogMarkdown < Redcarpet::Render::HTML
  include ActionView::Helpers

  def footnotes(content)
    content_tag :ul, content.html_safe, class: 'footnotes'
  end
end
