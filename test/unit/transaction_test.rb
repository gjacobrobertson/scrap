require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "fields" do
    transaction = transactions(:one)

    assert transaction.respond_to? :from_id
    assert transaction.respond_to? :to_id

    assert transaction.respond_to? :amount
    assert transaction.respond_to? :note
    assert transaction.respond_to? :label

    assert transaction.respond_to? :confirmed
  end

  test "associations" do
    transaction = transactions(:one)

    assert transaction.respond_to? :from
    assert transaction.respond_to? :to

    assert transaction.from.is_a? User
    assert transaction.to.is_a? User

    assert transaction.from == users(:one)
    assert transaction.to == users(:two)
  end
end
