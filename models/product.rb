class Product
  ALL = SimpleArticleFormat.load "#{PATH}/saf/products.saf"

  def self.all
    ALL
  end
end