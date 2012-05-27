class ApplicationController < ActionController::Base
  protect_from_forgery
  include SimpleCaptcha::ControllerHelpers
  
  before_filter :set_locale , :store_location

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
  
  def render_404
    respond_to do |format|
      format.html { render :template => "errors/404.html.erb", :status => :not_found }
    end
  end
  
  def store_location
      session[:user_return_to] = request.url unless params[:controller] == "devise/sessions"
      # If devise model is not User, then replace :user_return_to with :{your devise model}_return_to
  end
  
  def after_sign_in_path_for(resource)
    return request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end
end


