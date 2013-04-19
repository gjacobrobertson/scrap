module TransactionsHelper

  def and_others(transaction)
    case transaction.others_count
    when 0
      ""
    when 1
      " and 1 other"
    else
      " and #{transaction.others_count} others"
    end
  end

  def approved_credit_description(transaction)
    name = link_to transaction.to.name, transaction.to
    amount = number_to_currency transaction.amount
    others = and_others(transaction)

    case transaction
    when SplitTransaction
      note = transaction.note ? transaction.note : "a cost"
      "You split #{note} with #{name}#{others}. Their share was #{amount}."
    else
      "You gave #{amount} to #{name}"
    end
  end

  def approved_debt_description(transaction)
    name = link_to transaction.from.name, transaction.from
    amount = number_to_currency transaction.amount

    case transaction
    when SplitTransaction
      note = transaction.note ? transaction.note : "a cost"
      others = and_others(transaction)
      "#{name} split #{note} with you#{others}. Your share was #{amount}."
    else
      "#{name} gave you #{amount}"
    end
  end

  def rejected_credit_description(transaction)
    name = link_to transaction.to.name, transaction.to
    amount = number_to_currency transaction.amount

    case transaction
    when SplitTransaction
      note = transaction.note ? transaction.note : "a cost"
      "#{name} rejected their share of #{amount} for #{note}."
    else
      "#{name} rejected that you gave them #{amount}"
    end
  end

  def rejected_debt_description(transaction)
    name = link_to transaction.from.name, transaction.from
    amount = number_to_currency transaction.amount

    case transaction
    when SplitTransaction
      note = transaction.note ? transaction.note : "a cost"
      "You rejected your share of #{amount} for #{note}."
    else
      "You rejected that #{name} gave you #{amount}"
    end
  end

  def pending_credit_description(transaction)
    name = link_to transaction.to.name, transaction.to
    amount = number_to_currency transaction.amount

    case transaction
    when SplitTransaction
      others = and_others(transaction)
      note = transaction.note ? transaction.note : "a cost"
      "You split #{note} with #{name}#{others}. Their share is #{amount}."
    else
      "You gave #{amount} to #{name}."
    end
  end

  def pending_debt_description(transaction)
    name = link_to transaction.from.name, transaction.from
    amount = number_to_currency transaction.amount

    case transaction
    when SplitTransaction
      others = and_others(transaction)
      note = transaction.note ? transaction.note : "a cost"
      "#{name} split #{note} with you#{others}. Your share is #{amount}."
    else
      "#{name} gave you #{amount}."
    end
  end

  def credit_description(transaction)
    case transaction.confirmed
    when true
      approved_credit_description(transaction)
    when false
      rejected_credit_description(transaction)
    when nil
      pending_credit_description(transaction)
    end
  end

  def debt_description(transaction)
    case transaction.confirmed
    when true
      approved_debt_description(transaction)
    when false
      rejected_debt_description(transaction)
    when nil
      pending_debt_description(transaction)
    end
  end

  def description(transaction)
    case current_user
    when transaction.from
      credit_description(transaction)
    when transaction.to
      debt_description(transaction)
    end
  end

  def pic(transaction)
    case current_user
    when transaction.from
      facebook_profile_pic(transaction.to)
    when transaction.to
      facebook_profile_pic(transaction.from)
    end
  end
end
