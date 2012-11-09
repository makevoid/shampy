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

  get "/mission" do
    haml :mission
  end

  get "/preview" do
    haml :preview
  end

  # member

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