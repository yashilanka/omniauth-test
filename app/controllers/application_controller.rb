class ApplicationController < ActionController::Base
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(
  #       :email,
  #       :username,
  #       :password,
  #       :encrypted_password,
  #       :bio,
  #       :first_name,
  #       :last_name,
  #       :facebook,
  #       :twitter,
  #       :behance,) }
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
  #       :email,
  #       :username,
  #       :password,
  #       :encrypted_password,
  #       :bio,
  #       :first_name,
  #       :last_name,
  #       :facebook,
  #       :twitter,
  #       :behance,
  #   ) }
  # end

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  # Restrict Only for current user to edit
  def owner(obj)
    @className = obj.class.name.sub("Controller", "")
    instant = "/#{obj.class.name.pluralize.downcase}"
    unless obj.user_id == current_user.id
      flash[:notice] = 'Access denied as you are not owner of this ' + @className.singularize.downcase
      redirect_to instant
    end
  end
end
