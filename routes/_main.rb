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

  get "/filosofia" do
    haml :filosofia
  end

  get "/preview" do
    haml :preview
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
    haml :prodotti
  end

  # SinForum mounted on forum.shampy.it

end