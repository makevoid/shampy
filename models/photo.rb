class Photo

  def self.all
    @@all ||= SAF.get "#{PATH}/config/photos.saf"
  end

end