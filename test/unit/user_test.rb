require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "username cannot be empty" do
    user = User.new(name: "", password_digest: "secret")
    assert user.invalid?
    assert user.errors[:name].any?
  end

  test "username must be unique" do
    user = User.new(name: "dave", password_digest: "secret")
    assert !user.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'),
                 user.errors[:name].join('; ')
  end
end
