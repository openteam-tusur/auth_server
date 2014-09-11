class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, :if => :devise_controller?
  before_action :collect_user_info

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:surname, :name, :patronymic]
    devise_parameter_sanitizer.for(:account_update) << [:surname, :name, :patronymic]
  end

  def collect_user_info
    current_user.update_columns(:last_active_at => Time.zone.now, :user_agent => browser) if current_user
  end
end
