path = File.expand_path "../../", __FILE__

require "#{path}/config/env"

DataMapper.auto_migrate!

admin = User.create username: "admin", password: "secret", password_confirmation: "secret", role: :admin
member = User.create username: "member", password: "secret", password_confirmation: "secret", role: :member
guest = User.create username: "guest", password: "secret", password_confirmation: "secret", role: :guest