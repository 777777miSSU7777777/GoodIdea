require 'rails_helper'

RSpec.describe User, :type => :model do
    before :each do
        @user = User.new
        @user.name = "example_user"
        @user.email = "example_user@example.com"
        @user.password = "12345678"
        @user.save
    end

    after :each do
        @user.destroy
    end

    after :all do
        Rails.cache.clear
    end

    describe "#name_validation" do
        it "Name length is blank -> false" do
            @user.name = ''
            expect(@user).not_to be_valid
        end
        
        it "Name length is less than 8 -> false" do
            @user.name = '123'
            expect(@user).not_to be_valid
        end

        it "Name length is between 8 and 16 -> true" do
            @user.name = "x" * 12
            expect(@user).to be_valid
        end

        it "Name length is more than 16 -> false" do
            @user.name = "x" * 20
            expect(@user).not_to be_valid
        end
    end

    describe "#email_validation" do
        it "Email pattern is valid -> true" do
            expect(@user).to be_valid
        end

        it "Email pattern is not valid -> false" do
            @user.email = "123"
            expect(@user).not_to be_valid
        end

        it "Email is blank -> false" do
            @user.email = ""
            expect(@user).not_to be_valid
        end

        it "Email length is less than 12 -> false" do
            expect(@user.update(:email => "123@mail.ru")).to be_falsey
        end

        it "Email length is between 8 and 16 -> true" do
            expect(@user).to be_valid
        end

        it "Email length is more than 24 -> false" do
            expect(@user.update(:email => "12345678901234567890@example.com")).to be_falsey
        end
    end

    describe "#password_validation" do
        it "Password is blank -> false" do
            expect(@user.update(:password => nil)).to be_falsey
        end

        it "Password length is less than 8 -> false" do
            expect(@user.update(:password => "123")).to be_falsey
        end

        it "Password length is between 8 and 16 -> true" do
            expect(@user.update(:password => "1234567890")).to be_truthy
        end

        it "Password length is more than 16 -> false" do
            expect(@user.update(:password => "x" * 20)).to be_falsey
        end
    end
end