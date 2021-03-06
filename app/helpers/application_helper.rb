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
    link_to image_tag("https://graph.facebook.com/#{user.uid}/picture"), user
  end
end
