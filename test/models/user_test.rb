require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new
  end

  test "should be invalid => user is empty" do
    assert @user.invalid?
  end

  test "should be invalid => name length < 8" do
    @user.email = "pasha@mail.ru"
    @user.password = "12345678"
    
    @user.name = "Pavel"
    assert @user.invalid?
  end

  test "should be invalid => email length < 12" do
    @user.name = "Pavel Marjanskii"

    @user.email = "pavel@bk.ru"
    assert @user.invalid?
  end

  test "should be invalid => pass length < 8" do
    @user.email = "pasha@mail.ru"

    @user.password = "123"
    assert @user.invalid?
  end

  test "should be valid => all fields are correctly filled" do
    @user.name = "Pavel Marjanskii"
    @user.email = "pasha@mail.ru"
    @user.password = "12345678"
    assert @user.valid?
  end

end
