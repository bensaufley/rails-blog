class BlogPostDecorator < Draper::Decorator
  delegate_all

  def processed_content
    MARKDOWN.render model.content
  end

  def tag_links
    model.tags.map { |tag| h.link_to tag, h.tagged_posts_path(tag: tag) }.join(', ').html_safe
  end

  def timestamp
    h.content_tag(:time, model.publish_at.strftime('%Y-%m-%d at %-I:%M%P'), datetime: model.publish_at.xmlschema)
  end

  def title_link
    link_post = model.post_type == 'link' && model.info[:link_url].present?
    h.link_to(model.title.html_safe, link_post ? model.info[:link_url] : model) +
    (h.link_to(h.content_tag(:small, 'Permalink', class: 'permalink'), model) if link_post)
  end
end
