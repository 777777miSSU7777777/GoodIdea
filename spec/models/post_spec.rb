require 'rails_helper'

RSpec.describe Post, :type => :model do

    before :all do
        @user = User.new
        @user.id = 1
        @user.name = 'example_user'
        @user.email = 'example_user@example.com'
        @user.password = '12345678'
        @user.save
    end

    before :each do
        @post = Post.new
        @post.id = 1
        @post.title = 'x'
        @post.content = 'x'
        @post.goal = 1
        @post.user_id = 1
        @post.save
    end

    after :all do
        @user.destroy
        Rails.cache.clear
    end

    after :each do
        @post.destroy
        Rails.cache.clear
    end


    describe "#title_validation" do
        it 'Title is blank -> false' do
            @post.title = ''
            expect(@post).not_to be_valid  
        end

        it 'Title is not black and less than 30 symbols -> true' do
            @post.title = '123'
            expect(@post).to be_valid
        end

        it 'Title is more than 30 symbols -> false' do
            @post.title = 'x' * 35
            expect(@post).not_to be_valid
        end
    end

    describe "#content_validation" do

        it 'Content is blank -> false' do
            @post.content = ''
            expect(@post).not_to be_valid
        end

        it 'Content is not blank and less than 15000 symbols -> true' do
            @post.content = 'x'
            expect(@post).to be_valid
        end

        it 'Content is more 15000 symbols -> false' do
            @post.content = 'x' * 16000
            expect(@post).not_to be_valid
        end

        it 'Goal is less than zero -> false' do
            @post.goal = -1
            expect(@post).not_to be_valid
        end

        it 'Goal is zero -> false' do
            @post.goal = 0
            expect(@post).not_to be_valid
        end

        it 'Goal is more than zero -> false' do
            @post.goal = 1
            expect(@post).to be_valid
        end
    end
end


