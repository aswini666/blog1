class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @comments = @post.comments.includes(:user)  
  end

  def new
    @post =Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post, notice: "New post created successfully"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @post.update_attributes(post_params)
    if @post.save
      redirect_to @post, notice: "successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "successfully Deleted"
  end

  private
  def post_params
    params.require(:post).permit(:title, :description, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
