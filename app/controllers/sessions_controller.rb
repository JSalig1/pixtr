class SessionsController < ActionController::Base

  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email])  #find_by you use when looking for something other than :id params[:session][:email] is a hash within a hash params[access][access]
    # user = User.where(email: params[:session][:email]).find
    
    if user
      if user.authenticate(params[:session][:password])  #this will crash is Nil is user so we set up if statments
        cookies.permanent.signed[:user_id] = user.id  #signed makes the cookie tamper proof, otherwise it can be used to steal a user.id, permanent cookies expire in 20 years so people don't have to keep signing in.
      end
    end
    
    redirect_to root_path
  end
  
  
  def destroy
    cookies.delete :user_id
    redirect_to root_path
  end
  
end
