class ProjectsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def index
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def create
    @user = current_user
    @post = @user.posts.create(post_params)
    @post.current = 0
    if @post.save
      flash[:success] = "Your project post was created!"
      redirect_to project_path(@post)
    else
      render 'new'
    end
  end

  def update 
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to project_path(@post)
    else 
      render 'edit'
    end
  end

  def delete
    @post =  Post.find(params[:id])
    @post.destroy

    redirect_to root_path
  end

  private
    def post_params
      params.require(:post).permit(:title,:content, :goal)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_path
      end
    end

    def correct_user
      @post = Post.find(params[:id])
      redirect_to (login_path) unless current_user.id != @post.user
    end
end
