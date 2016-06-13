module ApplicationHelper
  def link_with_active(text = nil, path = nil, &block)
    if path.nil? && block_given?
      path = text
      text = nil
    end
    is_active = current_page?(path) || (path == root_path && current_page?(controller: :blog_posts, action: :index))
    if block_given?
      link_to(path, class: ('active' if is_active)) do
        yield
      end
    else
      link_to(text, path, class: ('active' if is_active), &block)
    end
  end
end
