module AdminHelper
  def breadcrumbs
    [link_to('Admin', admin_path), admin_action, controller_title, non_admin_action]
      .select(&:present?).join(' > ')
  end

  private

  def admin_action
    action_name.titleize if controller_name == 'admin' && action_name != 'index'
  end

  def controller_title
    unless controller_name == 'admin'
      link_to_if(action_name == 'index' && @search.blank?,
                 controller_name.titleize,
                 controller: controller_name, action: :index, tag: nil, type: nil)
    end
  end

  def non_admin_action
    @search.presence || action_name.titleize unless controller_name == 'admin'
  end
end
