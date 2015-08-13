class FollowController < ApplicationController
  def follow
    user = User.find(params[:user_id])
    current_user.follow(user)
    respond_to do |format|
      flash.now[:notice] = I18n.t "activerecord.attributes.follow.followed", user: user.name
      format.js
    end
  end
  def unfollow
    user = User.find(params[:user_id])
    current_user.stop_following(user)
    respond_to do |format|
      flash.now[:notice] = I18n.t "activerecord.attributes.follow.unfollowed", user: user.name
      format.js
    end
  end
end
