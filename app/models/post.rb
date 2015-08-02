class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :body
  has_many :comments, class_name: 'Post', foreign_key: 'original_post_id'
  belongs_to :original_post, class_name: 'Post'

  def self.comment
    where(original_post_id: true)
  end
  def self.original_post
    where(original_post_id: nil)
  end

end

#------------------------------------------------------------------------------
# Post
#
# Name       SQL Type             Null    Default Primary
# ---------- -------------------- ------- ------- -------
# id         integer              false           true
# body       text                 true            false
# user_id    integer              true            false
# created_at timestamp without time zone false           false
# updated_at timestamp without time zone false           false
#
#------------------------------------------------------------------------------
