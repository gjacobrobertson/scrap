module PagesHelper
  def format_amount(amount)
    case
    when amount < 0
      content_tag :span, number_to_currency(amount), :class => "negative"
    when amount > 0
      content_tag :span, number_to_currency(amount), :class => "positive"
    else
      number_to_currency(amount)
    end
  end

  def debt_total(user)
    amount = current_user.debt_to(user)
    case
    when amount < 0
      "Owes you #{number_to_currency(-1*amount)}"
    when amount == 0
      "All settled up"
    when amount > 0
      "You owe #{number_to_currency amount}"
    end
  end
end
