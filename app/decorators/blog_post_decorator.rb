class BlogPostDecorator < Draper::Decorator
  delegate_all

  def processed_content
    MARKDOWN.render model.content
  end

  def timestamp
    h.content_tag(:time, model.created_at.strftime('%Y-%m-%d at %-I:%M%P'), datetime: model.created_at.xmlschema)
  end

  def tag_links
    model.tags.map { |tag| h.link_to tag, h.tagged_posts_path(tag: tag) }.join(', ').html_safe
  end
end
