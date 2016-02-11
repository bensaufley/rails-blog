module ApplicationHelper
  def link_with_active(text, path)
    is_active = current_page?(path) || (path == root_path && current_page?(controller: :blog_posts, action: :index))
    link_to text, path, class: 'active' if is_active
  end
end
