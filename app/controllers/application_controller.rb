class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, :if => :devise_controller?
  before_action :collect_user_info
  before_action :collect_redirect_url

  layout :define_layout

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:surname, :name, :patronymic]
    devise_parameter_sanitizer.for(:account_update) << [:surname, :name, :patronymic]
  end

  def collect_user_info
    current_user.update_columns(:last_active_at => Time.zone.now, :user_agent => browser) if current_user
  end

  def collect_redirect_url
    session['redirect_url'] ||= params['redirect_url']
  end

  def after_sign_in_path_for(resource)
    session.delete('redirect_url') || super
  end

  def after_sign_out_path_for(resource)
    params['redirect_url'] || super
  end

  def define_layout
    devise_controller? ? 'session' : 'application'
  end
end
