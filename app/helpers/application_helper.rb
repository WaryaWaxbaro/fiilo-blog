module ApplicationHelper
  include Pagy::Frontend

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "position-fixed start-0 top-72 z-to-1200 w-100 text-center alert #{bootstrap_class_for(msg_type)} alert-dismissible fade show", role: "alert") do
        concat content_tag(:button, '', class: "btn-close", data: { bs_dismiss: 'alert' })
        concat message unless message == true
      end)
    end
    nil
  end
end
