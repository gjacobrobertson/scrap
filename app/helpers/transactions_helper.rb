module TransactionsHelper
  def approval_description(approval)
    case approval
    when SplitTransaction
      name = link_to approval.from.name, approval.from
      description = approval.note ? approval.note : 'a cost'
      with = "you"
      with = with + " and #{approval.others_count} others" if approval.others_count > 0
      share = number_to_currency(approval.amount)
      "#{name} split #{description} with #{with}. Your share is #{share}".html_safe
    else
      "TODO"
    end
  end

  def rejection_description(rejection)
    case rejection
    when SplitTransaction
      name = link_to rejection.to.name, rejection.to
      description = rejection.note ? rejection.note : 'a cost you split'
      share = number_to_currency(rejection.amount)
      "#{name} rejected their share of #{share} for #{description}".html_safe
    else
      "TODO"
    end
  end

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
    name = transaction.to.name
    amount = number_to_currency transaction.amount
    others = and_others(transaction)

    case transaction
    when SplitTransaction
      note = transaction.note ? transaction.note : "a cost"
      "You split #{note} with #{name}#{others}. Their share was #{amount}."
    end
  end

  def approved_debt_description(transaction)
    name = transaction.from.name
    amount = number_to_currency transaction.amount
    others = and_others(transaction)

    case transaction
    when SplitTransaction
      note = transaction.note ? transaction.note : "a cost"
      "#{name} split #{note} with you#{others}. Your share was #{amount}."
    end
  end

  def rejected_credit_description(transaction)
    name = transaction.to.name
    amount = number_to_currency transaction.amount

    case transaction
    when SplitTransaction
      note = transaction.note ? transaction.note : "a cost"
      "#{name} rejected their share of #{amount} for #{note}."
    end
  end

  def rejected_debt_description(transaction)
    amount = number_to_currency transaction.amount

    case transaction
    when SplitTransaction
      note = transaction.note ? transaction.note : "a cost"
      "You rejected your share of #{amount} for #{note}."
    end
  end

  def pending_credit_description(transaction)
    name = transaction.to.name
    amount = number_to_currency transaction.amount
    others = and_others(transaction)

    case transaction
    when SplitTransaction
      note = transaction.note ? transaction.note : "a cost"
      "You split #{note} with #{name}#{others}. Their share is #{amount}."
    end
  end

  def pending_debt_description(transaction)
    name = transaction.from.name
    amount = number_to_currency transaction.amount
    others = and_others(transaction)

    case transaction
    when SplitTransaction
      note = transaction.note ? transaction.note : "a cost"
      "#{name} split #{note} with you#{others}. Your share is #{amount}."
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
end
