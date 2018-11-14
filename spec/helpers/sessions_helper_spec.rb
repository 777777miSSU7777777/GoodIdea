require 'rails_helper'

RSpec.describe SessionsHelper do

        before :all do
            @user1 = User.new
            @user1.id = 1
            @user1.name = 'example_user'
            @user1.email = 'example_user@example.com'
            @user1.password = '12345678'
            @user1.save

            @user2 = User.new
            @user2.id = 2
            @user2.name = 'example_user1'
            @user2.email = 'example_user1@example.com'
            @user2.password = '12345678'
            @user2.save
        end

        after :all do
            @user1.destroy
            @user2.destroy
            Rails.cache.clear
        end

    describe "#log_in" do
        it 'Log in user1 and compares id with user_id from session -> success' do
            log_in(@user1)
            expect(session[:user_id]).to eq @user1.id 
        end

        it 'Log in user1 and compares user_id from session with user2 id -> fails' do
            log_in(@user1)
            expect(session[:user_id]).not_to eq @user2.id 
        end
    end

    describe "#remember" do
        it 'Remembers user1 and checks user_id and remember_token from cookies -> success' do
            remember(@user1)
            expect(cookies.permanent.signed[:user_id]).to eq @user1.id
            expect(cookies.permanent[:remember_token]).to eq @user1.remember_token
        end

        it 'Remembers user1 and checks user_id and remember_token from user2 -> success' do
            remember(@user1)
            expect(cookies.permanent.signed[:user_id]).not_to eq @user2.id
            expect(cookies.permanent[:remember_token]).not_to eq @user2.remember_token
        end
    end


    describe "#current_user" do
        it 'Log in user1 and current_user returns same user -> success' do 
            log_in(@user1)
            expect(@user1).to eq current_user
        end

        it 'Login and remember user1 and delete session to check cookie user search -> success' do
            log_in(@user1)
            remember(@user1)
            session.delete(:user_id)
            expect(@user1).to eq current_user
        end

        it 'Log in user1 and current_user compares with user2 -> fail' do 
            log_in(@user1)
            expect(@user2).not_to eq current_user
        end

        it 'Log in and remember user1 but delete remember token from cookies to fail cookie user search -> fail' do
            log_in(@user1)
            remember(@user1)
            cookies.delete(:remember_token)
            expect(@user1).to eq current_user
        end
    end

    describe "#current_user?" do
        it 'Log in user1 and current_user? compares user1 & user1 -> success' do 
            log_in(@user1)
            expect(true).to eq current_user?(@user1)
        end      

        it 'Log in user1 and current_user? compares user1 & user2 -> fail' do 
            log_in(@user1)
            expect(false).to eql current_user?(@user2)
        end
    end

    describe "#logged_in?" do
        it 'Log in and checks is user logged in? -> success' do 
            log_in(@user1)
            expect(true).to eq logged_in?
        end

        it 'Just tries to check user logged in? -> fail' do 
            expect(false).to eq logged_in?
        end
    end

    describe "#forget" do
        it 'Log in and forgets user1 -> success' do
            log_in(@user1)
            expect(true).to eq logged_in?
            forget(@user1)
            expect(nil).to eq cookies.permanent.signed[:user_id]
            expect(nil).to eq cookies.permanent[:remember_token]
        end

        it 'Just forgets current_user(w/o log in) -> fail' do
            expect{ forget(current_user)}.to raise_exception(NoMethodError)
        end
    end

    describe "#log_out" do
        it "Log in and log out -> success" do
            log_in(@user1)
            expect(true).to eq logged_in?
            expect(@user1.id).to eq session[:user_id]
            expect(@user1).to eq current_user
            expect(true).to eq current_user?(@user1)

            log_out
            expect(false).to eq logged_in?
            expect(nil).to eq session[:user_id]
            expect(nil).to eq current_user
        end

        it 'Just log out -> fail' do
            expect{ log_out }.to raise_exception(NoMethodError)
        end
    end
end