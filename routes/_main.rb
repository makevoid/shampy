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

  get "/foto_tagli" do
    haml :foto
  end

  get "/foto_tagli/:type" do |type|
    @type = type
    halt 404, "Not found" unless Type.all.include? type
    @photos = Photo.all @type
    haml :foto_type
  end

  get "/step_by_step" do
    haml :steps
  end

  get "/step_by_step/:type" do |type|
    @type = type
    halt 404, "Not found" unless Type.all.include? type
    haml :step_type
  end

  get "/step_by_step/:type/1" do |type|
    @type = :donna
    @title = "Taglio Lungo con Meshes"
    haml :step
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