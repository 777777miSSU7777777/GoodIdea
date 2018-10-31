class ProjectsController < ApplicationController
  def index
    @post = Post.all
  end

  def own
    @post = Post.where(user_id: current_user.id)
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @user = current_user
    @post = @user.posts.create(post_params)
    if @post.save
      flash[:success] = "Your project post was created!"
      redirect_to projects_own_path
    else
      render 'new'
    end
  end

  private
    def post_params
      params.require(:post).permit(:title,:content)
    end

end
