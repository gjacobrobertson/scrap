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
end
