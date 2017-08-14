class RegistrationsController < Devise::RegistrationsController
  #before_action :configure_permitted_parameters, :only => [:create]

  # def create
  #   super
  #   # could be changed later to #deliver_later
  #   UsersMailer.welcome(@user).deliver_now unless @user.invalid?
  # end

protected

  #def configure_permitted_parameters
  #  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, 
  #    :role, :password_confirmation) }
  #end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  

private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, 
      :password_confirmation, :role)
  end
end