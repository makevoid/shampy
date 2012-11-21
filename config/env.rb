path = File.expand_path '../../', __FILE__
PATH = path
APP = "shampy"

ADMIN_EMAIL = "cabrini1@hotmail.it"

require "bundler/setup"
Bundler.require :default
module Utils
  def require_all(path)
    Dir.glob("#{path}/**/*.rb") do |model|
      require model
    end
  end
end
include Utils

env = ENV["RACK_ENV"] || "development"
password = File.read(File.expand_path "~/.password").strip

user = env == "production" ? "root:#{password}@" : ""
DataMapper.setup :default, "mysql://#{user}localhost/shampy_#{env}"

require_all "#{path}/models"
require "#{path}/config/sinatra_exts.rb"

DataMapper.finalize

require "#{path}/lib/saf/products.saf"