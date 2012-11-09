path = File.expand_path '../../', __FILE__
APP = "shampy"

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
# DataMapper.setup :default, "mysql://localhost/shampy_#{env}"
require_all "#{path}/models"
# DataMapper.finalize