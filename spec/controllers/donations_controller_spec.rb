require 'rails_helper'
include SessionsHelper

RSpec.describe DonationsController, type: :controller do
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
        @post.current = 0
        @post.goal = 1
        @post.user_id = 1
        @post.save
    end

    after :each do
        @post.destroy
        @user1.destroy
    end

    after :all do
        Rails.cache.clear
    end
    
    describe "#donations_controller" do
        it "User donates to post -> success" do
            log_in @user1
            post "create", :params => {
                :post_id => 1,
                :donation => {
                    :msg => "Hello World",
                    :amount => 5
                }
            }
            expect(response).to redirect_to project_path(@post)
        end

        it "Quest donates to post -> fail" do
            post "create", :params => {
                :post_id => 1,
                :donation => {
                    :id => 1,
                    :msg => "Hello World",
                    :amount => 5
                }
            }
            expect(response).to redirect_to login_path
        end

        it "User incorrect donates to post -> success" do
            log_in @user1
            post "create", :params => {
                :post_id => 1,
                :donation => {
                    :id => 1,
                    :msg => "Hello World",
                    :amount => 0
                }
            }
            expect(response.status).to eq 200
        end

        it "User deletes donation message from post -> success" do
            log_in @user1
            post "create", :params => {
                :post_id => 1,
                :donation => {
                    :msg => "Hello World",
                    :amount => 5
                }
            }
            delete "destroy", :params => {
                :post_id => 1,
                :id => 1
            }
            expect(response).to redirect_to project_path(@post)
        end

        it "Quest deletes donation from post -> fail" do
            log_in @user1
            post "create", :params => {
                :post_id => 1,
                :donation => {
                    :msg => "Hello World",
                    :amount => 5
                }
            }
            log_out
            delete "destroy", :params => {
                :post_id => 1,
                :id => 1
            }
            expect(response).to redirect_to login_path
        end
    end


end
