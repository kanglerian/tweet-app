class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user = User.find_by(id: params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: "default_user.jpeg",
      password: params[:password]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Pendaftaran sudah berhasil!"
      redirect_to("/users/#{@user.id}")
    else
      render("/users/new")
    end
  end
  def edit
    @user = User.find_by(id: params[:id])
  end
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{@user.id}.jpeg"
      image = params[:image]
      File.binwrite("public/assets/image/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "Your account has been updated successfully"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  def form_login
  end
  def login
    @user = User.find_by(
      email: params[:email],
      password: params[:params]
    )
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "Login berhasil!"
      redirect_to("/post/index")
    else
      @error_message = "Email atau password salah!"
      render("users/login_form")
    end
  end
  def logout
    session[:user_id] = nil
    flash[:notice] = "Log out telah berhasil!"
    redirect_to("/login")
  end
end
