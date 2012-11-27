class Shampy < Sinatra::Base

  get "/" do
    haml :index
  end

  get "/chi_siamo" do
    haml :chi_siamo
  end

  get "/offerta" do
    haml :offerta
  end

  get "/lezioni" do
    haml :lezioni
  end

  # lezioni

  get "/lezioni/colore" do
    haml :"lezioni/colore"
  end

  get "/lezioni/massaggi" do
    haml :"lezioni/massaggi"
  end

  get "/lezioni/storia" do
    haml :"lezioni/storia"
  end

  # member

  get "/foto" do
    haml :foto
  end

  get "/foto/:type" do |type|
    @type = type
    halt 404, "Not found" unless Type.all.include? type
    haml :foto_type
  end

  get "/tagli" do
    haml :tagli
  end

  get "/norme" do
    haml :norme
  end

  get "/modelli" do
    haml :modelli
  end

  get "/prodotti" do
    @products = Product.all
    haml :prodotti
  end

  # SinForum mounted on forum.shampy.it

end