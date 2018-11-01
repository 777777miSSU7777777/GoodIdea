class CommentsController < ApplicationController
    def create 
        @user = current_user
        @post = Post.find(params[:post_id])
        @comment = Comment.new(comment_params)
        @user.comments << @comment
        @post.comments << @comment
        redirect_to project_path(@post)
    end

    private 
        def comment_params
            params.require(:comment).permit(:content)
        end
end
