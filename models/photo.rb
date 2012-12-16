class Photo

  attr_reader :path, :name, :file, :author

  @@all = {}

  def initialize(attributes={})
    @author = attributes[:author]
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
    @@all[type] ||= all_photos type
  end

  def self.all_photos(type)
    s3 = S3.new "shampy"
    photos = s3.files "foto", type
    photos.map do |full_path|
      title = full_path.split("/")[5]
      author = titles.find{ |t| t[:directory] == title }
      author = author[:name] if author
      Photo.new full_path: full_path, author: author
    end
  end

  def self.titles
    @@titles ||= SimpleArticleFormat.load "#{PATH}/saf/photos.saf"
  end

  # def self.all_photos(type)
  #   path = "img/foto/#{type}"
  #   photos = Dir.glob "#{PATH}/public/#{path}/*.{png,jpg}"
  #   photos.map do |full_path|
  #     Photo.new file: full_path, public_path: path
  #   end
  # end

end