require 'net/http'
require 'nokogiri'

class S3
  FILTER_EXT = "txt"

  attr_reader :bucket

  def initialize(bucket)
    @bucket = bucket
  end

  def self.get(bucket)
    new(bucket).get
  end

  def files(type, category, subcat=nil)
    filtered(type, category, subcat).map do |file|
      file[:url]
    end
  end

  def types
    all.map{ |key, val| key[:type] }.uniq
  end

  def categories(type)
    filtered(type).map do |key, val|
      key[:category]
    end.uniq
  end

  def subcats(type, category)
    filtered(type, category).map do |key, val|
      key[:subcat]
    end.uniq
  end

  def filtered(type, category=nil, subcat=nil)
    all.select do |key, val|
      cat = category.nil? ? true : key[:category] == category
      sub = subcat.nil?   ? true : key[:subcat]   == subcat
      key[:type] == type && cat && sub
    end
  end

  def all
    return @all if @all
    results = http_get_parse url
    files = results.search "Contents Key"
    @all = files.map do |file|
      file = file.text
      next if file =~ /\/$/
      next if file =~ /\.(#{FILTER_EXT})$/
      path = "#{url}#{file}"
      split = file.split("/")
      type, category, subcat, _ = split
      { type: type, category: category, subcat: subcat, url: path }
    end.compact
  end

  private

  def http_get_parse(url)
    Nokogiri::XML http_get(url)
  end

  def http_get(url)
    uri = URI.parse url
    resp = Net::HTTP.get_response uri
    resp.body
  end

  def url
    "http://#{@bucket}.s3.amazonaws.com/"
  end
end

# s3 = S3.new "shampy"
# p s3.types
# p s3.categories "foto"
# p s3.subcats "foto", "donna"
# p s3.files("foto", "donna", "colombo").size