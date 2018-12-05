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
        @post.title = '12345'
        @post.content = 'x' * 550
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
        it 'Title is blank -> fail' do
            @post.title = ''
            expect(@post).not_to be_valid  
        end

        it 'Title is less than 5 symbols -> fail' do
            @post.title = '123'
            expect(@post).not_to be_valid
        end

        it 'Title is between 5 and 30 -> success' do
            @post.title = 'x' * 15
            expect(@post).to be_valid
        end

        it 'Title is more than 30 symbols -> fail' do
            @post.title = 'x' * 35
            expect(@post).not_to be_valid
        end
    end

    describe "#content_validation" do

        it 'Content is blank -> fail' do
            @post.content = ''
            expect(@post).not_to be_valid
        end

        it 'Content is less than 500 symbols -> fail' do
            @post.content = 'x' * 300
            expect(@post).not_to be_valid
        end

        it 'Content is between 500 and 15000 symbols -> success' do
            @post.content = 'x' * 5000
            expect(@post).to be_valid
        end

        it 'Content is more than 15000 symbols -> fail' do
            @post.content = 'x' * 15500
            expect(@post).not_to be_valid
        end
    end
end


