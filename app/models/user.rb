class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  def self.random
    ids = connection.select_all("SELECT id FROM users")
    find(ids[rand(ids.length)]["id"].to_i) unless ids.blank?
  end
  def name
    '@' + (email.split '@').first
  end
end

#------------------------------------------------------------------------------
# User
#
# Name                   SQL Type             Null    Default Primary
# ---------------------- -------------------- ------- ------- -------
# id                     integer              false           true
# email                  character varying    false           false
# encrypted_password     character varying    false           false
# reset_password_token   character varying    true            false
# reset_password_sent_at timestamp without time zone true            false
# remember_created_at    timestamp without time zone true            false
# sign_in_count          integer              false   0       false
# current_sign_in_at     timestamp without time zone true            false
# last_sign_in_at        timestamp without time zone true            false
# current_sign_in_ip     inet                 true            false
# last_sign_in_ip        inet                 true            false
# created_at             timestamp without time zone false           false
# updated_at             timestamp without time zone false           false
#
#------------------------------------------------------------------------------
