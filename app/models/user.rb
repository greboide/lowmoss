class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :notifications do
    def active
      where( :active => true )
    end
  end

  acts_as_follower
  acts_as_followable
  def self.random
    ids = connection.select_all("SELECT id FROM users")
    find(ids[rand(ids.length)]["id"].to_i) unless ids.blank?
  end
  def name
    '@' + (email.split '@').first
  end

  def followed_you
    notif = notifications.active
    user_ids = []
    if notif.count > 0
      notif.each {|a| a.body[:type] == "followed" ? user_ids << a.body[:follower_id] : nil}
      notif.each { |b| b.created_at < (Time.now - 10.days) ? (b.active=false; b.save!;) : nil}
      # deactivate notifications older than 10 days
      users_names = []
      User.find(user_ids.uniq!).each { |a| users_names << a.name }
      return I18n.t "gflash.welcome.index.notification_followed", user: users_names.to_sentence(last_word_connector: ' e '),
              count: user_ids.size
    else
      return nil
    end
        #I18n.t gflash.welcome.index.notification_followed
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
