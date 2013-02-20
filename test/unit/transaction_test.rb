require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "fields" do
    transaction = transactions(:one)

    assert transaction.respond_to? :from_id
    assert transaction.respond_to? :to_id

    assert transaction.respond_to? :amount
    assert transaction.respond_to? :note
    assert trasnaction.respond_to? :label

    assert transaction.respond_to? :confirmed
  end

  test "associations" do
    transaction = transactions(:one)

    assert transaction.respond_to? :from
    assert transaction.respond_to? :to
  end
end
