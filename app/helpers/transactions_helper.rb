module TransactionsHelper
  def approval_description(approval)
    case approval.type
    when "SplitTransaction"
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
    case rejection.type
    when "SplitTransaction"
      name = link_to rejection.to.name, rejection.to
      description = rejection.note ? rejection.note : 'a cost you split'
      share = number_to_currency(rejection.amount)
      "#{name} rejected their share of #{share} for #{description}".html_safe
    else
      "TODO"
    end
  end
end
