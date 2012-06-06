
class SessionsController < ApplicationController
  layout 'login'

  def new
    if session[:user]
      redirect_to admin_root_path
    end
  end

  def destroy
    session[:user] = nil
    flash[:notice] = "You have been successfully logged out."
    redirect_to admin_root_path
  end

  def create
    if authenticate(params[:username], params[:password])
      session[:user] = params[:username]
      flash[:notice] = "You have been successfully logged in."
      redirect_to admin_root_path
    else
      flash[:error] = "Invalid username and/or password"
      render :new
    end
  end

  private
    def authenticate(username, password)
      if username == AUTH_CONFIG['username'] && encrypt(password) == AUTH_CONFIG['password']
        return true
      else
        return false
      end
    end

    def encrypt(string)
      Digest::SHA2.hexdigest(string)
    end
end
