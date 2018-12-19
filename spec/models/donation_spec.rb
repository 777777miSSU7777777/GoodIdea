require 'rails_helper'

RSpec.describe Donation, :type => :model do

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
        @post.title = 'x'
        @post.content = 'x'
        @post.goal = 100
        @post.user_id = 1
        @post.save
    end

    before :each do 
        @donation = Donation.new
        @donation.id = 1
        @donation.msg = 'x'
        @donation.amount = 1
        @donation.post_id = 1
        @donation.user_id = 1
    end

    after :all do
        @post.destroy
        @user.destroy
        Rails.cache.clear
    end

    after :each do
        @donation.destroy
        Rails.cache.clear
    end

    describe "#message_validation" do
        it 'Message is blank -> false' do
            @donation.msg = ''
            expect(@donation).not_to be_valid
        end

        it 'Message is not blank and less than 150 symbols -> true' do
            @donation.msg = 'x' * 150
            expect(@donation).to be_valid
        end

        it 'Message is more than 150 -> false' do
            @donation.msg = 'x' * 350
            expect(@donation).not_to be_valid
        end
    end

    describe "#amount_validation" do
        it 'Amount is less than zero -> false' do
            @donation.amount = -1
            expect(@donation).not_to be_valid
        end

        it 'Amount is zero -> false' do
            @donation.amount = 0
            expect(@donation).not_to be_valid
        end

        it 'Amount is more than zero -> false' do
            @donation.amount = 1
            expect(@donation).to be_valid
        end
    end
end