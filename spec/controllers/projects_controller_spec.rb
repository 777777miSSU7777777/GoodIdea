require 'rails_helper'
include SessionsHelper

RSpec.describe ProjectsController, type: :controller do
    describe "#projects_controller" do
        before :each do
            @user1 = User.new
            @user1.id = 1
            @user1.name = 'example_user'
            @user1.email = 'example_user@example.com'
            @user1.password = '12345678'
            @user1.save
            
            @post = Post.new
            @post.id = 1
            @post.title = "x"
            @post.content = "x"
            @post.goal = 1
            @post.user_id = 1
            @post.save
        end

        after :each do
            @post.destroy
        end

        after :all do
            Rails.cache.clear
        end

        it 'Returns index page -> true' do
            get 'index'
            expect(response).to render_template("index")
        end

        it 'Returns new page -> true' do
            get 'new'
            expect(response).to render_template("new")
        end

        it 'Returns edit page if logged-> true' do
            log_in @user1
            get 'edit', :params => { :id => 1}
            expect(response).to render_template("edit")
        end

        it 'Logged user updates post -> success' do
            log_in @user1
            post "update", :params => {
                :id => 1,
                :post => {
                    :title => "123",
                    :content => "123",
                    :goal => 10
                }
            }
            expect(response).to redirect_to action: "show", :id => 1
        end

        it 'Returns login page if not logged-> true' do
            get 'edit', :params => { :id => 1}
            expect(response).to redirect_to login_path
        end

        it 'Not logged user doesnt update post -> true' do
            post "update", :params => {
                :id => 1,
                :post => {
                    :title => "123",
                    :content => "123",
                    :goal => 10
                }
            }
            expect(response).to redirect_to login_path
        end
    end
end
