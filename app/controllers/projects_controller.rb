class ProjectsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Your project post was created!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
    def post_params
      params.require(:post).permit(:title,:content)
    end

end
