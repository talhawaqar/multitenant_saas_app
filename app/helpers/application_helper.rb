module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }[flash_type.to_sym] || "alert-info"
  end

  def flash_messages(_opts = {})
    flash.each do |msg_type, message|
      concat(
        content_tag(:div, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible fade show", role: "alert") do
          concat message
          concat button_tag(type: 'button', class: 'btn-close', data: { bs_dismiss: 'alert' }, aria: { label: 'Close' }) {}
        end
      )
    end
    nil
  end
end
