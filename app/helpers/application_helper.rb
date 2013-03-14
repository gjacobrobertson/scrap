module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def facebook_profile_pic(user)
    image_tag("https://graph.facebook.com/#{user.uid}/picture")
  end

  def approval_description(approval)
    case approval.type
    when "SplitTransaction"
      "#{approval.from.name} split #{number_to_currency(approval.split_total)} #{"for #{approval.note}" if approval.note} with you #{"and #{approval.others_count} others" if approval.others_count > 0}"
    else
      "You owe #{approval.from.name} #{number_to_currency(approval.amount)} for #{approval.note}"
    end
  end
end
