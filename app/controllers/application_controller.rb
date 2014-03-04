class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :is_user_allowed_to?, :is_current_user?, :ensure_that_signed_in

  def current_user
  	return session[:user_id].nil? ? nil : User.find(session[:user_id])
  end

  def ensure_that_signed_in
    if(current_user.nil?)
      redirect_to signin_path
    end
  end

  def is_current_user?(user)
    return current_user.nil? ? false : current_user.id==user.id
  end

  def is_user_allowed_to?(action)
  	if(current_user.nil?)
  		return false
  	elsif(Admin.find_by(user_id: current_user.id).nil?)
  		return false
  	end
  	admin = Admin.find(current_user.id)
  	return admin.send(action)
  end
end
