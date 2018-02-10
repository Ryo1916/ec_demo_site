class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: params[:username])
    if user and user.authenticate(params[:password])
      # session[] is global variable.
      session[:uid] = user.id
      session[:username] = user.username
      session[:password] = user.password_digest
      session[:image] = user.image.url
      flash[:notice] = "login successful !"
      redirect_to controller: "products", action: "index"
    else
      render action: "new"
      # redirect_to action: "new"
    end
  end

  def omniauth_create
    auth = request.env["omniauth.auth"]
    session[:omniauth] = auth.except('extra')
    user = User.sign_in_from_omniauth(auth)
    if !user.blank?
      session[:uid] = user.id
      session[:username] = user.username
      session[:email] = auth.info.email
      session[:image] = auth.info.image
      flash[:notice] = "login successful !"
      redirect_to controller: "products", action: "index"
    else
      render action: "new"
    end
  end

  def destroy
    session.delete(:uid)
    session.delete(:username)
    session.delete(:password)
    session.delete(:image)
    session.delete(:omniauth)
    flash[:notice] = "logout successful."
    redirect_to root_path
  end

end
