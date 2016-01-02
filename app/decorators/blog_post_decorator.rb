class BlogPostDecorator < Draper::Decorator
  delegate_all

  def processed_content
    model.content
  end
end
