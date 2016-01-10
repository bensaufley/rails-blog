module AdminHelper
  def breadcrumbs
    crumbs = [ link_to('Admin', admin_path) ]
    if controller_name == 'admin' && action_name != 'index'
      crumbs << action_name.titleize
    elsif controller_name != 'admin'
      if action_name == 'index' && @search.blank?
        crumbs << controller_name.titleize
      else
        crumbs << link_to(controller_name.titleize, { controller: controller_name, action: :index, tag: nil, type: nil })
        if @search.present?
          crumbs << @search
        else
          action_name.titleize
        end
      end
    end
    crumbs.join(' > ')
  end
end
