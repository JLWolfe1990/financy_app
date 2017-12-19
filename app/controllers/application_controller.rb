class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_tenant!
  
     ##    milia defines a default max_tenants, invalid_tenant exception handling
     ##    but you can override these if you wish to handle directly
  rescue_from ::Milia::Control::MaxTenantExceeded, :with => :max_tenants
  rescue_from ::Milia::Control::InvalidTenantAccess, :with => :invalid_tenant

  before_action :authenticate_tenant!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authorize_user, unless: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def authorize_user
    redirect_to new_user_session_path unless current_user
  end

  def authenticate_tenant!
    return true if try(:devise_controller?)

    super
  end
end
