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

  def description_for(transaction)
    from = transaction.from == current_user ? "You" : transaction.from.name
    to = transaction.to == current_user ? "You" : transaction.to.name
    possessive = transaction.to == current_user ? "Your" : "#{transaction.to.name}'s"
    note = transaction.note ? transaction.note : "a cost"
    amount = number_to_currency transaction.amount
    others = case transaction.others_count
             when 0
               ""
             when 1
               " and 1 other"
             else
               " and #{transaction.others_count} others"
             end
    return "#{from} split #{note} with #{to}#{others}. #{possessive} share is #{amount}"
  end
end
