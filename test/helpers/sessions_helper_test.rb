require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

    setup do
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

    teardown do
        @user1.destroy
        @user2.destroy
        Rails.cache.clear
    end

    test 'log_in_test__correct_user__success' do
        log_in(@user1)
        assert_equal @user1.id, session[:user_id]
    end

    test 'log_in_test_incorrect_user__fail' do
        log_in(@user1)
        assert_not_equal @user2.id, session[:user_id]
    end

    test 'remember_test__correct_user__success' do
        remember(@user1)
        assert_equal @user1.id, cookies.permanent.signed[:user_id]
        assert_equal @user1.remember_token, cookies.permanent[:remember_token]
    end

    test 'remember_test__incorrect_user__fail' do
        remember(@user1)
        assert_not_equal @user2.id, cookies.permanent.signed[:user_id]
        assert_not_equal @user2.remember_token, cookies.permanent[:remember_token]
    end

    test 'current_user_test__correct_user__success' do
        log_in(@user1)
        assert_equal @user1, current_user 
    end

    test 'current_user_test__incorrect_user__fail' do
        log_in(@user1)
        assert_not_equal @user2, current_user 
    end

    test 'current_user?_test__correct_user__success' do
        log_in(@user1)
        assert_equal true, current_user?(@user1)
    end

    test 'current_user?_test__incorrect_user__fail' do
        log_in(@user1)
        assert_equal false, current_user?(@user2)
    end

    test 'logged_in?_test__logged_user__success' do
        log_in(@user1)
        assert_equal true, logged_in?
    end
    
    test 'logged_in?__test__nobody_logged__fail' do
        assert_equal logged_in?, false
    end

    test 'forget_test__logged_user__success' do
        log_in(@user1)
        assert_equal true, logged_in?
        forget(@user1)
        assert_nil cookies.permanent.signed[:user_id]
        assert_nil cookies.permanent[:remember_token]
    end

    test 'forget_test__nobody_logged__fail' do
        assert_raise do 
            forget(current_user)
        end
    end

    test 'log_out_test__logged_user__success' do
        log_in(@user1)
        assert_equal true, logged_in?
        assert_equal @user1.id, session[:user_id]
        assert_equal @user1, current_user
        assert_equal true, current_user?(@user1)

        log_out
        assert_equal false, logged_in?
        assert_nil session[:user_id]
        assert_nil current_user
    end

    test 'log_out_test__nobody_logged__fail' do
        assert_raise do
            log_out
        end
    end
end