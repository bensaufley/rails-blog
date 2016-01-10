module ApplicationHelper
  def link_with_active(text, path)
    link_to text, path, class: ('active' if current_page?(path) || (path == root_path && current_page?(controller: :blog_posts, action: :index)))
  end
end
