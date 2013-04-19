module SplitsHelper
  def alertMessage(object)
    if object.valid?
      case object
      when Split
        "Sucessfully Split #{number_to_currency(object.amount)}"
      when Transaction
        "Gave #{number_to_currency(object.amount)} to #{object.to.name}"
      end
    else
      content_tag :ul do
        object.errors.full_messages.collect do |error|
          concat(content_tag :li, error)
        end
      end
    end
  end
end
