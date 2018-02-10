class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  def home

  end

  def show
    @user = User.find(params[:id])
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # file = params[:user][:image]
    # if !file.nil?
    #   file_name = file.original_filename
    #   File.open("public/user_images/#{file_name}", 'wb')
    #     {|f| f.write(file.read)}
    #   @user.image = file_name
    # end
    if @user.save
      flash[:notice] = "Created your account !"
      redirect_to login_path
    else
      render("/users/new")
    end
  end

  def update
    @user = User.find(params[:id])
    # @user.username = params[:username]
    # @user.password = params[:password]
    # @user.email = params[:email]
    # @user.phone = params[:phone]
    # @user.image = params[:image]
    if @user.save(user_params)
      session[:username] = @user.username
      session[:password] = @user.password_digest
      session[:image] = @user.image.url
      flash[:notice] = "Update successfully !"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Account deleted! Thank you using this site!"
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :phone, :gender, :date_of_birth, :image)
    end
end
