path = File.expand_path '../', __FILE__

require "#{path}/config/env.rb"

class Shampy < Sinatra::Base
  include Voidtools::Sinatra::ViewHelpers

  @@path = File.expand_path '../', __FILE__

  set :root, @@path

  require "#{@@path}/lib/form_helpers"
  include FormHelpers

  require "#{@@path}/lib/markup_utils.rb"
  include MarkupUtils

  configure :development do
    before do
      unless defined?(@@session_set)
        @@session_set = true
        session[:user_id] = User.last.id
      end
    end
  end

  def photos_from(path)
    Dir.glob("#{PATH}/public/img/#{path}/*.{png,jpg}").map do |photo|
      File.basename photo
    end.shuffle
  end

  before do
    @photos = photos_from "gallery"
  end

  def gallery_from(path)
    photos_from(path).each_with_index do |photo, idx|
      haml_tag :img, { class: "pos#{idx}", src: "/img/#{path}/#{photo}" }
    end
  end

  # partial :comment, { comment: "blah" }
  # partial :comment, comment

  def partial(name, value)
    locals = if value.is_a? Hash
      value
    else
      hash = {}; hash[name] = value
      hash
    end
    haml "_#{name}".to_sym, locals: locals
  end

  # flash messages

  def flash
    @@flashes ||= {}
  end

  after do
    @@flashes = {}
  end

end

class Array
  def evens
    select.each_with_index { |item, i| i.even? }
  end

  def odds
    select.each_with_index { |item, i| i.odd? }
  end
end

require_all "#{path}/routes"

LOAD_MODULES_ROUTES.call