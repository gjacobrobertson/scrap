class FacebookController < ApplicationController
  def friends
    user = FbGraph::User.me(session[:access_token])
    friends = user.friends.collect{|f| {:id => f.identifier, :name => f.name}}
    friends = friends.select{|f| f[:name].downcase.include? params[:q].downcase} if params[:q]
    render :json => friends.to_json
  end
end
