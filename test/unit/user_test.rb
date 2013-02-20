require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "fields" do
    user = users(:one)
    assert user.respond_to? :name
    assert user.respond_to? :provider
    assert user.respond_to? :uid
  end

  test "associations" do
    user = users(:one)
    assert user.respond_to? :debits
    assert user.respond_to? :credits

    assert user.debits.is_a? Array
    assert user.credits.is_a? Array

    assert user.debits.size == 1
    assert user.credits.size == 1

    assert user.debits.first.is_a? Transaction
    assert user.debits.first.is_a? Transaction
  end
end
