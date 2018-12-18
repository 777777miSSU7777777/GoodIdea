require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, :type => :controller do
    describe "#users_controller" do
        before :each do
            @user1 = User.new
            @user1.id = 1
            @user1.name = 'example_user'
            @user1.email = 'example_user@example.com'
            @user1.password = '12345678'
            @user1.save
        end

        after :all do
            Rails.cache.clear
        end

        it 'Returns index page -> success' do
            get 'index'
            expect(response).to render_template("index")  
        end

        it 'Returns show page -> success' do
            get 'show', :params => { :id => 1 }
            expect(response).to render_template("show")
        end

        it 'Returns create page -> success' do
            get 'new'
            expect(response).to render_template("new")
        end

        it 'Create new valid user -> success' do
            post 'create', :params => { :user => {
                :name => 'example_user',
                :email => 'example_user@example.com',
                :password => '12345678'
            }}
            expect(response.status).to eq 200 
        end

        it 'Create new invalid user -> fail' do
            post 'create', :params => { :user => {
                :name => 'example_user',
                :email => 'example_user@example.com',
                :password => ''
            }}
            expect(response).to render_template("new")
        end

        it 'Logged user getting access to profile edit page -> success' do
            log_in @user1
            get "edit", :params => { :id => 1}
            expect(response).to render_template("edit")
        end

        it 'Logged user submit updated profile -> success' do
            log_in @user1
            post "update", :params => { 
                :id => 1,
                :user => {
                    :name => 'updated_user',
                    :email => 'example_user@example.com',
                    :password => '12345678'
            }}
            
            expect(response).to redirect_to action: "show", id: 1
        end
    end
end