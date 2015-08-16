class Notification < ActiveRecord::Base
  belongs_to :user
  serialize :body
  scope :active, -> () { where active: true}
end

#------------------------------------------------------------------------------
# Notification
#
# Name       SQL Type             Null    Default Primary
# ---------- -------------------- ------- ------- -------
# id         integer              false           true
# user_id    integer              true            false
# active     boolean              true            false
# body       character varying    true            false
# created_at timestamp without time zone false           false
# updated_at timestamp without time zone false           false
#
#------------------------------------------------------------------------------
