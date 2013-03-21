module SplitsHelper
  def alertMessage(split)
    if @split.valid?
      "Sucessfully Split #{number_to_currency(@split.amount)}"
    else

      content_tag :ul do
        @split.errors.full_messages.collect do |error|
          concat(content_tag :li, error)
        end
      end
    end
  end
end
