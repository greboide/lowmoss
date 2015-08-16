class Follow < ActiveRecord::Base

  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" interface, and also to followers
  belongs_to :followable, :polymorphic => true
  belongs_to :follower,   :polymorphic => true

  def block!
    self.update_attribute(:blocked, true)
  end

  after_create :notify_followed
  before_destroy :notify_unfollowed

  private

  def notify_followed
    notification = Notification.new
    notification.user_id = followable_id
    notification.active = true
    notification.body = {type: "followed", follower_id: follower_id}
    notification.save!
  end

  def notify_unfollowed
    notification = Notification.new
    notification.user_id = followable_id
    notification.active = true
    notification.body = {type: "unfollowed", follower_id: follower_id}
    notification.save!
  end
end

#------------------------------------------------------------------------------
# Follow
#
# Name            SQL Type             Null    Default Primary
# --------------- -------------------- ------- ------- -------
# id              integer              false           true   
# followable_id   integer              false           false  
# followable_type character varying    false           false  
# follower_id     integer              false           false  
# follower_type   character varying    false           false  
# blocked         boolean              false   false   false  
# created_at      timestamp without time zone true            false  
# updated_at      timestamp without time zone true            false  
#
#------------------------------------------------------------------------------
