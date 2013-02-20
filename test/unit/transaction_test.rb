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

  test "validations" do
    transaction = transactions(:one)
    assert transaction.valid?
  end

  test "amount_validations" do
    transaction = transactions(:one)
    transaction.amount = 0
    assert !transaction.valid?
    transaction.amount = -1
    assert !transaction.valid?
    transaction.amount = nil
    assert !transaction.valid?
  end

  test "from_validations" do
    transaction = transactions(:one)
    transaction.from = nil
    assert !transaction.valid?
  end

  test "to_validations" do
    transaction = transactions(:one)
    transaction.to = nil
    assert !transaction.valid?
  end

  test "note_validations" do
    transaction = transactions(:one)
    transaction.note = nil
    assert transaction.valid?
    transaction.note = ""
    assert transaction.valid?
  end

  test "label_validations" do
    transaction = transactions(:one)
    transaction.label = nil
    assert !transaction.valid?
    transaction.label = ""
    assert !transaction.valid?
    transaction.label = "bogus"
    assert !transaction.valid?
    transaction.label = "give"
    assert transaction.valid?
  end
end
