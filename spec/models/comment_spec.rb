require 'rails_helper'

RSpec.describe Comment, :type => :model do

    before :all do
        @user = User.new
        @user.id = 1
        @user.name = 'example_user'
        @user.email = 'example_user@example.com'
        @user.password = '12345678'
        @user.save
    end

    before :all do
        @post = Post.new
        @post.id = 1
        @post.title = '12345'
        @post.content = 'x' * 550
        @post.user_id = 1
        @post.save
    end

    before :each do 
        @comment = Comment.new
        @comment.id = 1
        @comment.content = 'x' * 15
        @comment.post_id = 1
        @comment.user_id = 1
    end

    after :all do
        @post.destroy
        @user.destroy
        Rails.cache.clear
    end

    after :each do
        @comment.destroy
        Rails.cache.clear
    end

    describe "#content_validation" do
        it 'Content is blank -> fail' do
            @comment.content = ''
            expect(@comment).not_to be_valid
        end
        
        it 'Content is less than 30 symbols -> fail' do
            @comment.content = 'x' * 20
            expect(@comment).not_to be_valid
        end

        it 'Content is between 30 and 300 symbols -> success' do
            @comment.content = 'x' * 150
            expect(@comment).to be_valid
        end

        it 'Content is more than 300 symbols -> fail' do
            @comment.content = 'x' * 350
            expect(@comment).not_to be_valid
        end
    end
end