class BlogPostDecorator < Draper::Decorator
  delegate_all

  def excerpt(parsed=true)
    content = model.content.gsub(/<!--more-->.+\z/m, ' ' + h.link_to('More…', model, class: 'more-link'))
    parsed ? processed_content(content) : content
  end

  def processed_content(content = model.content)
    markdown(content).gsub(/&lt;!--(.+?)--&gt;/,'<!--\1-->') # fixes
  end

  def tag_links
    model.tags.map { |tag| h.link_to tag, h.tagged_posts_path(tag: tag) }.join(', ').html_safe
  end

  def timestamp
    h.content_tag(:time, model.publish_at.strftime('%Y-%m-%d at %-I:%M%P'), datetime: model.publish_at.xmlschema)
  end

  def title_link
    link_post = model.post_type == 'link' && model.info[:link_url].present?
    h.link_to(model.title.html_safe, link_post ? model.info[:link_url] : model, target: ('_blank' if link_post)) +
    ((h.link_to '', model, class: 'permalink', title: 'Permalink') if link_post)
  end

  private
  def markdown(content)
    @@markdown ||= Redcarpet::Markdown.new(
      renderer,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      autolink: true,
      disable_indented_code_blocks: true,
      strikethrough: true,
      lax_spacing: true,
      space_after_headers: false,
      superscript: true,
      underline: false,
      highlight: true,
      quote: false,
      footnotes: true
    )

    @@markdown.render(content)
  end

  def renderer
    @renderer ||= BlogMarkdown.new(
      filter_html: false,
      no_images: false,
      no_links: false,
      no_styles: true,
      escape_html: false,
      safe_links_only: false,
      with_toc_data: true,
      hard_wrap: false,
      xhtml: false,
      prettify: true,
      link_attributes: {}
    )
  end
end
