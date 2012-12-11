class Photo

  attr_reader :path, :name, :file

  def initialize(attributes={})
    if attributes[:full_path]
      @path = attributes[:full_path]
      @name = File.basename @path
    else
      @file = attributes[:file]
      @name = File.basename @file
      @path = "/#{attributes[:public_path]}/#{@name}"
    end
  end

  def self.all(type)
    # @@all ||= SAF.get "#{PATH}/config/photos.saf"
    @@all ||= all_photos type
  end

  def self.all_photos(type)
    s3 = S3.new "shampy"
    photos = s3.files("foto", "donna", "colombo")
    photos.map do |full_path|
      Photo.new full_path: full_path
    end
  end

  # def self.all_photos(type)
  #   path = "img/foto/#{type}"
  #   photos = Dir.glob "#{PATH}/public/#{path}/*.{png,jpg}"
  #   photos.map do |full_path|
  #     Photo.new file: full_path, public_path: path
  #   end
  # end

end