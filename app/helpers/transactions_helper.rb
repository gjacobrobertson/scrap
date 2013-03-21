module TransactionsHelper
  def approval_description(approval)
    case approval.type
    when "SplitTransaction"
      description = approval.note ? approval.note : 'a cost'
      with = "you"
      with = with + " and #{approval.others_count} others" if approval.others_count > 0
      share = number_to_currency(approval.amount)
      "#{approval.from.name} split #{description} with #{with}. Your share is #{share}"
    else
      "TODO"
    end
  end

  def rejection_description(rejection)
    case rejection.type
    when "SplitTransaction"
      description = rejection.note ? rejection.note : 'a cost you split'
      share = number_to_currency(rejection.amount)
      "#{rejection.to.name} rejected their share of #{share} for #{description}"
    else
      "TODO"
    end
  end
end
