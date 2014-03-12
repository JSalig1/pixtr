class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
  private
  
  def current_user
    if cookies[:user_id]
      @current_user ||= User.find_by(id: cookies.signed[:user_id]) #right side is only executed when the left side is false or nil.  otherwise no.
    end
  end
  helper_method :current_user #normally you can use this method in controllers only, this line lets you use it in views as well
 
 
  def signed_in?
    current_user
  end
  helper_method :signed_in?
  
end
