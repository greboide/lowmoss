Jumpup::Heroku.configure do |config|
  config.app = 'lowmoss'
end if Rails.env.development?
