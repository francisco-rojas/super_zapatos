module ApplicationHelper
  def set_active_item(path)
    'class = active' if current_page?(path)
  end
end
