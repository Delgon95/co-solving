module ApplicationHelper
  def is_admin?
    !current_user.nil? and current_user.is_admin
  end
end
