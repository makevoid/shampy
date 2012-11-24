class Product
  # ALL = SimpleArticleFormat.load "#{PATH}/saf/products.saf"

  def self.all
    SimpleArticleFormat.load "#{PATH}/saf/products.saf"
  end
end