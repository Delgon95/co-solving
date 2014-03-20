module ApplicationHelper
  def is_admin?
    !current_user.nil? and current_user.is_admin
  end

  def current_user_id
    unless current_user.nil?
      return current_user.id
    end
    nil
  end

  def humanize secs
    [[60, :seconds], [60, :minutes], [24, :hours], [1000, :days]].map{ |count, name|
      if secs > 0
        secs, n = secs.divmod(count)
        "#{n.to_i} #{name}"
      end
    }.compact.reverse.join(' ')
  end
end
