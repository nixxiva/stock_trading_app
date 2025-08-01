class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :is_admin])
  end
  
  def after_sign_in_path_for(current_user)
    current_user.is_admin? ? admin_root_path : root_path
  end

  def set_stock_data
    FmpApi.get_stock_info if !defined?($stock_data)
  end

  def authorize_admin!
    unless current_user.present? && current_user.is_admin? && current_user.is_approved?
    redirect_to root_path, alert: "You are not authorized to access this administrative area."
    end
  end
  
  def trader_check
    if current_user.is_admin
      redirect_to admin_root_path, alert: "redirected, for traders only"
    end
  end

end

