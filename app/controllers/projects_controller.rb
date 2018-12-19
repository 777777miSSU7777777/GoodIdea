class ProjectsController < ApplicationController
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

    redirect_to own_projects_path
  end

  private
    def post_params
      params.require(:post).permit(:title,:content, :goal)
    end

end
