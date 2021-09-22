class PostController < ApplicationController

  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
  end

  def create
    @post = Post.new(content: params[:content],user_id: @current_user.id)
    if @post.save
      flash[:notice] = "Alhamdulillaah, Postingan berhasil ditambahkan!"
      redirect_to("/post/index")
    else
      render("/post/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "Selamat, data berhasil diubah!"
      redirect_to("/post/index")
    else
      render("post/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "Postingan berhasil di hapus!"
    redirect_to("/post/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id.to_i != @current_user.id
      flash[:notice] = "Gak bisa akses!"
      redirect_to("/post/index")
    end
  end
end
