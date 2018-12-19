class DonationsController < ApplicationController
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
                format.html { redirect_to @post }
            end
        else
            render 'projects/show'
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        @donation = @post.donations.find(params[:id])
        if @donation.destroy
            respond_to do |format|
                format.js
                format.html {redirect_to @post}
            end
        else
            render 'projects/show'
        end

    private 
        def donation_params
            params.require(:donation).permit(:msg,:amount)
        end
end
