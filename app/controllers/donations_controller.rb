class DonationsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]

    def create 
        @user = current_user
        @post = Post.find(params[:post_id])
        @donation = Donation.new(donation_params)
        @user.donations << @donation
        @post.donations << @donation
        if @donation.save
            @post.update(:current => @post.current + @donation.amount)
            respond_to do |format|
                format.js
                format.html { redirect_to project_path(@post) }
            end
        else
            render 'projects/show'
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        @donation = @post.donations.find_by(params[:id])
        if @donation.destroy
            respond_to do |format|
                format.js
                format.html {redirect_to project_path(@post)}
            end
        else
            render 'projects/show'
        end
    end

    private 
        def donation_params
            params.require(:donation).permit(:msg,:amount)
        end

        def logged_in_user
            unless logged_in?
              store_location
              flash[:danger] = "Please log in."
              redirect_to login_path
            end
          end
      
          def correct_user
            @donation = Donation.find(params[:id])
            @post = Post.find(params[:post_id])
            redirect_to (login_path) unless (current_user.id != @donation.user_id || current_user.id != @post.user_id)
          end
end
