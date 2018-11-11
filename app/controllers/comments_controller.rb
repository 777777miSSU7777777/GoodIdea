class CommentsController < ApplicationController
    def create 
        @user = current_user
        @post = Post.find(params[:post_id])
        @comment = Comment.new(comment_params)
        @user.comments << @comment
        @post.comments << @comment
        if @comment.save
            respond_to do |format|
                format.js
                format.html { redirect_to @post }
            end
        else
            render 'projects/show'
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        if @comment.destroy
            respond_to do |format|
                format.js
                format.html {redirect_to @post}
            end
        else
            render 'projects/show'
        end
    end
    
    private 
        def comment_params
            params.require(:comment).permit(:content)
        end
end
