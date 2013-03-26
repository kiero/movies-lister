
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

  def update
    auth_config = {}
    unless params[:password] == params[:password_confirmation]
      flash[:error] = "Password and password confirmation are not the same!"
      redirect_to admin_root_path
      return false
    end

    File.open("#{Rails.root}/config/authentication.yml", 'w+') do |f| 
      f.write(prepare_yaml(auth_config))
    end
    auth_config['username'] = params[:username]
    auth_config['password'] = params[:password]
    flash[:notice] = "Username and/or password have been successfully changed."
    redirect_to admin_root_path
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
      Digest::SHA2.hexdigest(string).force_encoding("UTF-8")
    end

    def prepare_yaml(hash)
      hash['password'] = encrypt(hash['password'])
      hash.to_yaml.gsub("!ruby/symbol ", ":").sub("---","").split("\n").map(&:rstrip).join("\n").strip
    end
end
